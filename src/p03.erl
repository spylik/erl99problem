%% =========================================================================================
%% @doc
%% P03 (*) Найти N-й элемент списка:
%% Пример:
%% 1> p03:element_at([a,b,c,d,e,f], 4).
%% d
%% 2> p03:element_at([a,b,c,d,e,f], 10).
%% undefined
%% @end
%% =========================================================================================
-module(p03).

-include_lib("eunit/include/eunit.hrl").

-export([
		element_at/2
	]).

element_at([], _) 		-> 
	undefined;

element_at([H|_T], 1)	-> 
	H;

element_at([_H|T], Num)	-> 
	element_at(T,Num-1).

% ======================================== test suite ======================================

elementat_char_test() -> 
	d = element_at([a,b,c,d,e,f], 4).

elementat_num_test() -> 
	5 = element_at([1,2,5,3,3,6], 3).

