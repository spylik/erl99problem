%% =====================================================================================
%% @doc
%% P11 (**) Закодировать список с использованием модифицированого алгоритма RLE:
%% Пример:
%% 1> p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},b,{2,c},{2,a},d,{4,e}]
%% @end
%% =====================================================================================
-module(p11).

-include_lib("eunit/include/eunit.hrl").

-export([
		encode_modified/1
	]).

% In last argument we will keep result list 
encode_modified(List) -> 
	encode_modified(List, [], [], []).

% When we got [] in first argument it means we finish and we can return result
encode_modified([], _, _, Result) -> 
	p05:reverse(Result);

encode_modified([H|T], [], [], Result) -> 
	encode_modified(T, {1, H}, H, Result);

encode_modified([H|[]], {Num,El}, _Element=H, Result) -> 
	encode_modified([], {Num+1,El}, H, [{Num+1,El}|Result]);

encode_modified([H|[]], {1,El}, _Element, Result) -> 
	encode_modified([], {1, H}, H, [H, El|Result]);

encode_modified([H|[]], {Num,El}, _Element, Result) -> 
	encode_modified([], {1, H}, H, [H, {Num,El}|Result]);

encode_modified([H|T], {Num,El}, _Element=H, Result) -> 
	encode_modified(T, {Num+1, El}, H, Result);

encode_modified([H|T], {1,El}, _Element, Result) -> 
	encode_modified([H|T], [], [], [El|Result]);

encode_modified([H|T], {Num,El}, _Element, Result) -> 
	encode_modified([H|T], [], [], [{Num, El}|Result]).



% ======================================== test suite ======================================

encode_modified_a_test() -> 
	[{4,a},b,{2,c},{2,a},d,{4,e}] = encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
encode_modified_b_test() -> 
	[{4,1},2,{4,3},4,{4,5}] = encode_modified([1,1,1,1,2,3,3,3,3,4,5,5,5,5]).
encode_modified_c_test() -> 
	[{4,a},b,{2,c},{2,a},d,e] = encode_modified([a,a,a,a,b,c,c,a,a,d,e]).
encode_modified_d_test() -> 
	[a,b,{2,c},{2,a},d,e] = encode_modified([a,b,c,c,a,a,d,e]).

