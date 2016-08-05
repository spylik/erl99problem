-module(cache_handler).

% Standart cowboy callbacks
-export([
		init/3,
		allowed_methods/2,
		content_types_accepted/2,
		content_types_provided/2
	]).

% Custom callbacks
-export([
		parse_json_request/2
	]).

% cowboy_rest cowboy-behaviour allowed us using many futures such as known_methods/content_types_provided, etc.
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

% we going to allowed only POST request
allowed_methods(Req, State) ->
	{[<<"POST">>, <<"GET">>], Req, State}.

% we have to implement only json content type 
content_types_accepted(Req, State) ->
    {[  
        {<<"application/json">>, parse_json_request}
    ], Req, State}.
content_types_provided(Req, State) ->
    {[  
        {<<"application/json">>, parse_json_request}
    ], Req, State}.


% handle json request
parse_json_request(Req, State) ->
	{ok, [{Json,true}], Req3} = cowboy_req:body_qs(Req),
	{Dec} = jsone:decode(Json),
	Reply = process_request(Dec),
	lager:debug("decode is ~p, Reply is ~p",[Dec, Reply]),
	case cowboy_req:method(Req3) of
		{<<"POST">>, Req4} ->
%			{<<Json/binary>>, Req4, State};
			{true, Req4, State};
			%{{true, <<Json/binary>>}, Req, State};
		{<<"GET">>, Req4} ->
			Body = jsone:encode(Reply),
			{Body, Req4, State}
	end.

process_request([{<<"action">>, <<"insert">>},{<<"key">>, Key},{<<"value">>, Value}]) ->
	cache_server:insert(Key,Value);

process_request([{<<"action">>, <<"lookup">>},{<<"key">>, Key}]) ->
	cache_server:lookup(Key);

process_request([{<<"action">>, <<"lookup_by_date">>},{<<"date_from">>, DateFrom}, {<<"date_to">>, DateTo}]) ->
	cache_server:lookup_by_date(DateFrom,DateTo).
