%% =====================================================================================
%% @doc
%% P13 (**) Написать декодер для стандартного алгоритма RLE:
%% Пример:
%% 1> p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]
%% @end
%% =====================================================================================
-module(p13).

-include_lib("eunit/include/eunit.hrl").

-export([
		decode/1
	]).

% In last argument we will keep result list 
decode(List) -> 
	p05:reverse(decode(List, [])).

% When we got [] in first argument it means we finish and we can return result
decode([], Result) -> Result;

decode([{0, _El}|T], Result) -> 
	decode(T, Result);
decode([{Num, El}|T], Result) -> 
	decode([{Num-1, El}|T], [El|Result]).


% ======================================== test suite ======================================

decode_a_test() -> 
	[a,a,a,a,b,c,c,a,a,d,e,e,e,e] = decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
decode_b_test() -> 
	[1,1,1,1,2,3,3,3,3,4,5,5,5,5] = decode([{4,1},{1,2},{4,3},{1,4},{4,5}]).
decode_c_test() -> 
	[a,a,a,a,b,c,c,a,a,d,e] = decode([{4,a},{1,b},{2,c},{2,a},{1,d},{1,e}]).
decode_d_test() -> 
	[a,b,c,c,a,a,d,e] = decode([{1,a},{1,b},{2,c},{2,a},{1,d},{1,e}]).
