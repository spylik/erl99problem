%% =====================================================================================
%% @doc
%% P12 (**) Написать декодер для модифицированого алгоритма RLE:
%% Пример:
%% 1> p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]
%% @end
%% =====================================================================================
-module(p12).

-include_lib("eunit/include/eunit.hrl").

-export([
		decode_modified/1
	]).

% In last argument we will keep result list 
decode_modified(List) -> 
	decode_modified(List, []).

% When we got [] in first argument it means we finish and we can return result
decode_modified([], Result) -> 
	p05:reverse(Result);

decode_modified([{0, _El}|T], Result) -> 
	decode_modified(T, Result);

decode_modified([{Num, El} = _H|T], Result) -> 
	decode_modified([{Num-1, El}|T], [El|Result]);

decode_modified([El|T], Result) -> 
	decode_modified([{0, El}|T], [El|Result]).

% ======================================== test suite ======================================

decode_modified_a_test() -> 
	[a,a,a,a,b,c,c,a,a,d,e,e,e,e] = decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]) .
decode_modified_b_test() -> 
	[1,1,1,1,2,3,3,3,3,4,5,5,5,5] = decode_modified([{4,1},2,{4,3},{1,4},{4,5}]).
decode_modified_c_test() -> 
	[a,a,a,a,b,c,c,a,a,d,e] = decode_modified([{4,a},b,{2,c},{2,a},d,e]).
decode_modified_d_test() -> 
	[a,b,c,c,a,a,d,e] = decode_modified([a,b,{2,c},{2,a},d,e]).

