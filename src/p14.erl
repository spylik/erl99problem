%% =====================================================================================
%% @doc
%% P14 (*) Написать дубликатор всех элементов входящего списка:
%% Пример:
%% 1> p14:duplicate([a,b,c,c,d]).
%% [a,a,b,b,c,c,c,c,d,d]
%% @end
%% =====================================================================================
-module(p14).

-include_lib("eunit/include/eunit.hrl").

-export([
		duplicate/1
	]).

duplicate([H|T]) ->
	[H,H|duplicate(T)];
duplicate([]) ->
	[].

% ======================================== test suite ======================================

duplicate_a_test() -> 
	[a,a,b,b,c,c,c,c,d,d] = duplicate([a,b,c,c,d]).
duplicate_b_test() -> 
	[a,a,a,a,b,b,c,c,c,c,d,d,d,d] = duplicate([a,a,b,c,c,d,d]).
duplicate_c_test() -> 
	[1,1,2,2,1,1] = duplicate([1,2,1]).
