%% =========================================================================================
%% @doc
%% P06 (*) Определить, является ли список палиндромом:
%% Пример:
%% 1> p06:is_palindrome([1,2,3,2,1]).
%% true
%% @end
%% =========================================================================================
-module(p06).

-include_lib("eunit/include/eunit.hrl").

-export([
		is_palindrome/1,
		is_palindrome2/1
	]).


% =================================== first version (check mirror) ==========================

is_palindrome(List)				->	is_palindrome(List,p05:reverse(List)).

% final true /false matching
is_palindrome(_A,_A)			->	true;
is_palindrome(_A,_B)			->	false.

% ---------------------------------- end of first version (check mirror) --------------------



% =========================== second version (split list for 2 side) ========================
% TODO: need make some optimisation and do not go to recursion two times when splitting lists

% We going to use different functions via pattern matching for even and odd lists
is_palindrome2(List) ->Len = p04:len(List),
	check_palindrome(List, Len, Len div 2, Len rem 2).
	
% pattern matching for event lists
check_palindrome(List,	Len,	LenDiv,	0)			->
	check_palindrome(
		split_list(List, [], {0, LenDiv, 0}), 
		p05:reverse(split_list(List, [], {LenDiv, Len, 0}))
	);
% pattern matching for non-even (odd) lists
check_palindrome(List,	Len,	LenDiv,	_LenRem) 	->
	check_palindrome(
		split_list(List, [], {0, LenDiv, 0}), 
		p05:reverse(split_list(List, [], {LenDiv+1, Len, 0}))
	).

% final true /false matching
check_palindrome(_A,_A)			->	true;
check_palindrome(_A,_B)			->	false.


% going to cut list from Start till End

% when End=Start we complete splitting and return the List
split_list(_List1,	List,	{_Start,	_End=_Start,	_ElementID}) 		->	List;

% when ElementID == Start we starting splitting with subtracting from End (ElementID without changes)
split_list([H|T],	List,	{Start,		End,			ElementID=Start})	->
	split_list(T, [H|List], {Start, End-1, ElementID});

% when ElementID != Start we going up (End without changes, ElementID going up)
split_list([_H|T],	List,	{Start,		End,			ElementID})			->
	split_list(T, List, {Start, End, ElementID+1}).


% ---------------------- end of second version (split list for 2 side) ----------------------


% ======================================== test suite =======================================

palindrome1_a_test() -> true = is_palindrome([1,2,3,2,1]).
palindrome2_a_test() -> true = is_palindrome2([1,2,3,2,1]).
palindrome1_b_test() -> false = is_palindrome([1,2,3,2]).
palindrome2_b_test() -> false = is_palindrome2([1,2,3,2]).
palindrome1_c_test() -> true = is_palindrome([a,b,c,b,a]).
palindrome2_c_test() -> true = is_palindrome2([a,b,c,b,a]).
palindrome1_d_test() -> false = is_palindrome([a,b,c,b]).
palindrome2_d_test() -> false = is_palindrome2([a,b,c,b]).
palindrome1_e_test() -> true = is_palindrome([1,2,2,1]).
palindrome2_e_test() -> true = is_palindrome2([1,2,2,1]).
palindrome1_f_test() -> true = is_palindrome([]).
palindrome2_f_test() -> true = is_palindrome2([]).
palindrome1_g_test() -> true = is_palindrome([1]).
palindrome2_g_test() -> true = is_palindrome2([1]).


