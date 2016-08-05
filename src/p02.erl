%% =========================================================================================
%% @doc
%% P02 (*) Найти два последних элемента списка:
%% Пример:
%% 1> p02:but_last([a,b,c,d,e,f]).
%% [e,f]
%% @end
%% =========================================================================================
-module(p02).

-include_lib("eunit/include/eunit.hrl").

-export([
		but_last/1,
		but_last2/1
	]).

% First version
but_last([_H|[T1,T2]])		->	[T1,T2];
but_last([_H|T])			->	but_last(T).

% Second version
but_last2([_H|[_,_] = L])	->	L;
but_last2([_H|T]) 			->	but_last2(T).


% ======================================== test suite ======================================

butlast1_char_test() -> 
	[e,f] = but_last([a,b,c,d,e,f]).

butlast2_char_test() -> 
	[e,f] = but_last2([a,b,c,d,e,f]).

butlast1_num_test() -> 
	[5,2] = but_last([1,4,3,5,2]).

butlast2_num_test() -> 
	[5,2] = but_last2([1,4,3,5,2]).

