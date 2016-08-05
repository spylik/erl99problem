%% =====================================================================================
%% @doc
%% P15 (**) Написать функцию-репликатор всех элементов входящего списка:
%% Пример:
%% 1> p15:replicate([a,b,c], 3).
%% [a,a,a,b,b,b,c,c,c]
%% @end
%% =====================================================================================
-module(p15).

-include_lib("eunit/include/eunit.hrl").

-export([
		replicate/2
	]).

replicate(List, Times) -> 
	replicate(List, Times, Times).

replicate([H|T], 1, BaseNum) -> 
	[H|replicate(T, BaseNum, BaseNum)];

replicate([H|_] = List, CurNum, BaseNum) -> 
	[H|replicate(List, CurNum -1, BaseNum)];

replicate([], _, _) -> 
	[].

% ======================================== test suite ======================================

replicate_a_test() -> 
	[a,a,a,b,b,b,c,c,c] = replicate([a,b,c],3).
replicate_b_test() -> 
	[a,a,a,a,b,b,c,c,c,c,d,d] = replicate([a,a,b,c,c,d],2).
replicate_c_test() -> 
	[1,1,1,2,2,2,1,1,1] = replicate([1,2,1],3).
