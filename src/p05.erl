%% =========================================================================================
%% @doc
%% P05 (*) Перевернуть список:
%% Пример:
%% 1> p05:reverse([1,2,3]).
%% [3,2,1]
%% @end
%% =========================================================================================
-module(p05).

-include_lib("eunit/include/eunit.hrl").

-export([
		reverse/1
	]).

% We going to save reversed List in second argument.
reverse(List) ->
	reverse(List, []).

reverse([H|T], List) -> 
	reverse(T, [H|List]);

reverse([], List) -> 
	List.

% ======================================== test suite ======================================

reverse_char_test() -> 
	[d,c,b,a] = reverse([a,b,c,d]).
reverse_num_test() -> 
	[3,2,1] = reverse([1,2,3]).

