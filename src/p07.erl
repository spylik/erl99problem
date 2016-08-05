%% =========================================================================================
%% @doc
%% P07 (**) Выровнять структуру с вложеными списками:
%% Пример:
%% 1> p07:flatten([a,[b,[c,d],e]]).
%% [a,b,c,d,e]

%% @end
%% =========================================================================================
-module(p07).

-include_lib("eunit/include/eunit.hrl").

-export([
		flatten/1
	]).


% In second argument we will keep normalized list
flatten(List) -> 
	flatten(List, []).

% When we got [] in first argument it means we finish and we can return result
flatten([], Result) -> 
	Result;

% this pattern will match normal list and try to process it recursively
% TODO: I think we could got memory leak with big lists because this is not tail recursion.
% Need some research and try to write second implementation with purely tail recursion.
flatten([H|T], Result) ->
	flatten(H, flatten(T, Result));

% this pattern will match simple elements
flatten(List, Result) ->
	[List|Result].


% ======================================== test suite ======================================

flatten_a_test() -> 
	[a,b,c,d,e] = flatten([a,[b,[c,d],e]]).
flatten_b_test() -> 
	[a,b,c,d,e] = flatten([[a,[b,[c,d],e]]]).
flatten_c_test() -> 
	[a,b,c,d,e] = flatten([a,[b,[c,d],[e]]]).
flatten_d_test() -> 
	[a,b,c,d,e] = flatten([a,[b,[c,[d]],[e]]]).
