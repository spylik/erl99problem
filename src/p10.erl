%% =====================================================================================
%% @doc
%% P10 (**) Закодировать список с использованием алгоритма RLE:
%% Пример:
%% 1> p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]
%% @end
%% =====================================================================================
-module(p10).

-include_lib("eunit/include/eunit.hrl").

-export([
		encode/1
	]).

% In last argument we will keep result list 
encode(List) -> 
	encode(List, [], [], []).

% When we got [] in first argument it means we finish and we can return result
encode([], _, _, Result) -> 
	p05:reverse(Result);

encode([H|T], [], [], Result) -> 
	encode(T, {1, H}, H, Result);
encode([H|[]], {Num,El}, _Element=H, Result) -> 
	encode([], {Num+1,El}, H, [{Num+1,El}|Result]);
encode([H|[]], {Num,El}, _Element, Result) -> 
	encode([], {1, H}, H, [{1, H}, {Num,El}|Result]);
encode([H|T], {Num,El}, _Element=H, Result) -> 
	encode(T, {Num+1, El}, H, Result);
encode([H|T], {Num,El}, _Element, Result) -> 
	encode([H|T], [], [], [{Num, El}|Result]).


% ======================================== test suite ======================================

encode_a_test() -> 
	[{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}] = encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
encode_b_test() -> 
	[{4,1},{1,2},{4,3},{1,4},{4,5}] = encode([1,1,1,1,2,3,3,3,3,4,5,5,5,5]).
encode_c_test() -> 
	[{4,a},{1,b},{2,c},{2,a},{1,d},{1,e}] = encode([a,a,a,a,b,c,c,a,a,d,e]).
encode_d_test() -> 
	[{1,a},{1,b},{2,c},{2,a},{1,d},{1,e}] = encode([a,b,c,c,a,a,d,e]).

