%% =====================================================================================
%% @doc
%% P09 (**) Запаковать последовательно следующие дубликаты во вложеные списки:
%% Пример:
%% 1> p09:pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
%% @end
%% =====================================================================================
-module(p09).

-include_lib("eunit/include/eunit.hrl").

-export([
		pack/1
	]).

% In last argument we will keep result list 
pack(List) -> pack(List, [], [], []).

% When we got [] in first argument it means we finish and we can return result
pack([], _, _, Result) -> 
	p05:reverse(Result);

pack([H|T], [], [], Result) -> 
	pack(T, [H], H, Result);
pack([H|[]], Temp, _Element=H, Result) -> 
	pack([], [H], H, [[H|Temp]|Result]);
pack([H|[]], Temp, _Element, Result) -> 
	pack([], [H], H, [[H]|[Temp|Result]]);
pack([H|T], Temp, _Element=H, Result) -> 
	pack(T, [H|Temp], H, Result);
pack([H|T], Temp, _Element, Result) -> 
	pack([H|T], [], [], [Temp|Result]).

% ======================================== test suite ======================================

pack_a_test() -> 
	[[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]] = pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
pack_b_test() -> 
	[[a,a,a,a],[b],[c,c],[a,a],[d],[e]] = pack([a,a,a,a,b,c,c,a,a,d,e]).
pack_c_test() -> 
	[[a],[b],[c,c],[a,a],[d],[e]] = pack([a,b,c,c,a,a,d,e]).
