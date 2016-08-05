%% =====================================================================================
%% @doc
%% P08 (**) Удалить последовательно следующие дубликаты:
%% Пример:
%% 1> p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [a,b,c,a,d,e]
%% @end
%% =====================================================================================
-module(p08).

-include_lib("eunit/include/eunit.hrl").

-export([
		compress/1
	]).


% In second argument we will keep last processed element and in third - normalized list
compress(List) ->
	compress(List,	[],	[]).

% When we got [] in first argument it means we finish and we can return result
compress([], _Symb, Result) ->
	p05:reverse(Result);

% when symbol== head and second element same as head
compress([H=Symb|[H|T]], Symb, Result) ->
	compress(T, H, Result);

% when second same as head
compress([H|[H|T]], _Symb, Result) -> 
	compress(T, H, [H|Result]);

% when symbol == head but second element not same as head
compress([H=Symb|T], Symb, Result) -> 
	compress(T, H, Result);

% all others patterns
compress([H|T], _Symb, Result) -> 
	compress(T, H, [H|Result]).


% ======================================== test suite ======================================

compress_char_test() -> 
	[a,b,c,a,d,e] = compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).

compress_num_test() -> 
	[1,2,1,2,1,11,2,3,4,3] = compress([1,1,1,2,1,2,1,11,2,3,4,3]).
