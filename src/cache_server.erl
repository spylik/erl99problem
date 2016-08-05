-module(cache_server).

% gen server is here
-behaviour(gen_server).

-include("include/cache.hrl").

% gen_server api
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

% our public api
-export([
		start_link/0,
		start_link/1,
		stop/0,
		insert/2,
		lookup/1,
		lookup_by_date/2,
		now_sec/0
	]).

% we will use ?MODULE as servername
-define(SERVER, ?MODULE).

% record for keep state
-record(state, {ttl,tref}).


% star/stop api
start_link() ->
    CacheTTL = case application:get_env(cache_server, cache_ttl) of
        undefined -> 3600;
        {ok, TTL} -> TTL
    end,
	start_link([{ttl, CacheTTL}]).

start_link([Args]) ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, Args, []).
stop() ->
    gen_server:call(?SERVER, stop, infinity).


% init
init({ttl, TTL}) ->
	ets:new(cache, [set, {keypos,#cache.key}, named_table]),
	TRef = erlang:send_after(100, self(), heartbeat),
	{ok, #state{ttl=TTL, tref=TRef}}.


%--------------lib api----------------

% insert value
insert(Key, Value) ->
	gen_server:call(?SERVER, {insert, Key, Value}).

lookup(Key) ->
	gen_server:call(?SERVER, {lookup, Key}).

lookup_by_date(DateFrom, DateTo) ->
	gen_server:call(?SERVER, {lookup_by_date, DateFrom, DateTo}).
%-----------end of lib api-------------


%--------------handle_call----------------

% insert
handle_call({insert, Key, Value}, _From, State) ->
	ets:insert(cache, #cache{key=Key, value=Value, datesec=now_sec()}),
	{reply, [{key, Key},{value, Value}], State};

% lookup_ver
handle_call({lookup, Key}, _From, State) ->
	Expire = now_sec() - State#state.ttl,
	case ets:lookup(cache, Key) of
		[Data = #cache{}] when Data#cache.datesec > Expire -> 
			Reply = [{key, Key}, {value, Data#cache.value}];
		_ -> 
			Reply = [{key, Key}, {value, undefined}]
	end,
    {reply, Reply, State};

% lookup_by_date_ver1
handle_call({lookup_by_date, DateFrom, DateTo}, _From, State) ->
	Expire = now_sec() - State#state.ttl,
	DateFromSec=calendar:datetime_to_gregorian_seconds(DateFrom),
	DateToSec=calendar:datetime_to_gregorian_seconds(DateTo),
	DateFromMax = erlang:max(Expire,DateFromSec),
	MS = [
			{{cache,'_','_','$1'},
				[
					{'<','$1',{const,DateToSec}},
   					{'>','$1',{const,DateFromMax}}
				],
				['$_']
			}
		],
	Reply = ets:select(cache, MS), 
	{reply, Reply, State};

%% handle_call for all other thigs
handle_call(Msg, _From, State) ->
	lager:warning("we are in undefined handle_call in module ~p with message ~p~n",[?MODULE,Msg]),
    {reply, ok, State}.
%-----------end of handle_call-------------


%--------------handle_cast-----------------

%% handle_cast for all other thigs
handle_cast(Msg, State) ->
	lager:warning("we are in undefined handle cast in module ~p with message ~p~n",[?MODULE,Msg]),
    {noreply, State}.
%-----------end of handle_cast-------------


%--------------handle_info-----------------
handle_info(heartbeat, State) ->
    lager:debug("got hearbeat ttl: ~p NOW: ~p~n",[State#state.ttl,cache_server:now_sec()]),
    _ = erlang:cancel_timer(State#state.tref),
	OldThan = now_sec() - State#state.ttl,
    clean_cache(OldThan),
    TRef = erlang:send_after(1000, ?SERVER, heartbeat),
    {noreply, State#state{tref=TRef}};


%% handle_info for all other thigs
handle_info(Msg, State) ->
	lager:warning("we are in undefined handle info in module with message ~p~n",[?MODULE,Msg]),
    {noreply, State}.
%-----------end of handle_info-------------


terminate(Reason, State) ->
	{noreply, Reason, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%------------non-genserv functions-----------

now_sec() ->
	calendar:datetime_to_gregorian_seconds(calendar:now_to_datetime(now())).

clean_cache(OldThan) ->
    clean_cache(OldThan, ets:first(cache)).

clean_cache(OldThan, LastKey) ->
    case ets:lookup(cache, LastKey) of
        [Data = #cache{}] when Data#cache.datesec < OldThan ->
            ets:delete(cache, LastKey),
            clean_cache(OldThan,ets:next(cache, LastKey));
        _ -> ok
    end.
