%% --------------------------------------------------------------------------------
%% @doc 99 Erlang Problems
%% Based on L-99: Ninety-Nine Lisp Problems
%% Based on a Prolog problem list by werner.hett@hti.bfh.ch
%% @end
%% --------------------------------------------------------------------------------

-module(erl99problems).
-compile(export_all).

%%% @doc p01 Find the last box of a list.
%%% eg
%%%    p01([1,2,3,4])
%%%    > 4
%%% @end

p01([T|[]]) ->
    T;
p01([_H|T]) ->
    p01(T).

%%% @doc p02 Find the last but one box of a list.
%%% eg
%%%    erl99problems:p02([a,b,c,d,e,f,g]).
%%%    > [f,g]
%%% @end

p02([H1|[H2|[]]]) ->
    [H1,H2];
p02([_H|T]) ->
    p02(T).

%%% @doc p03 Find the K'th element of a list
%%% eg
%%%     erl99problems:p03([1,2,3,f,b,3,f,s], 4).
%%%     > f
%%% @end
p03(List, El) ->
    p03(List, El, 1).

p03([H|_T], _Num, _Num) ->
    H;
p03([_H|T], El, Num) ->
    p03(T, El, Num+1).

%--- delete this line and write your code for p03 here ---%

%%% @doc p04 Find the number of elements of a list.
%%% eg
%%%     erl99problems:p04([1,2,x,3,4,5]).
%%%     > 6
%%% @end
p04(List) ->
    p04(List, 1).
p04([_H|[]], Num) ->
    Num;
p04([_H|T], Num) ->
    p04(T, Num+1).
%--- delete this line and write your code for p04 here ---%

%%% @doc p05 Reverse a list.
%%% eg
%%%     erl99problems:p05([1,z,2,3,4]).
%%%     > [4,3,2,z,1]
%%% @end

%--- delete this line and write your code for p05 here ---%

%%% @doc p06 Find out whether a list is a palindrome.
%%% eg
%%%     erl99problems:p06([1,2,3,2,1]).
%%%     > true
%%%     erl99problems:p06([1,2,3,3,1]).
%%%     > false
%%% @end

%--- delete this line and write your code for p06 here ---%

%%% @doc p07 Flatten a nested list structure
%%% eg
%%%     erl99problems:p07([a,[b,[c,d],e]]).
%%%     > [a,b,c,d,e]
%%% @end

%--- delete this line and write your code for p07 here ---%

%%% @doc p08 Eliminate consecutive duplicates of list elements.
%%% eg
%%%     erl99problems:p08([a,a,a,a,b,c,c,a,a,d,e,e,e,e).
%%%     > [a,b,c,d,e]
%%% @end

%--- delete this line and write your code for p08 here ---%

%%% @doc p09 Pack consecutive duplicates of list elements into sublists.
%%% eg
%%%     erl99problems:p09([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%%     > [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
%%% @end

%--- delete this line and write your code for p09 here ---%

%%% @doc p10 Run-length encoding of a list.
%%% eg
%%%     erl99problems:p10([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%%     > [[a,4],[b,1],[c,2],[a,2],[d,1],[e,4]]
%%% @end

%--- delete this line and write your code for p10 here ---%

%%% @doc p11 Modified run-length encoding
%%% eg
%%%     erl99problems:p10([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%%     > [[a,4],b,[c,2],[a,2],d,[e,4]]
%%% @end

%--- delete this line and write your code for p11 here ---%

%%% @doc p12 Decode a run-length encoded list.
%%% eg
%%%     erl99problems:p12([[a,4],b,[c,2],[a,2],d,[e,4]]).
%%%     > [a,a,a,a,b,c,c,a,a,d,e,e,e,e]
%%% @end

%--- delete this line and write your code for p12 here ---%

%%% @doc p13 Run length encoding of a list
%%% eg
%%%     erl99problems:p13([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%%%     > [[4,a],b,[2,c],[2,a],d,[4,e]]
%%% @end

%--- delete this line and write your code for p13 here ---%

%%% @doc p14 Duplicate elements of a list.
%%% eg
%%%     erl99problems:p14([a,b,c,d]).
%%%     > [a,a,b,b,c,c,d,d]
%%% @end

%--- delete this line and write your code for p14 here ---%

%%% @doc p15 Replicate the elements of a list a given number of times.
%%% eg
%%%     erl99problems:p15([a,b,c],3).
%%%     > [a,a,a,b,b,b,c,c,c]
%%% @end

%--- delete this line and write your code for p15 here ---%

%%% @doc p16 Drop every N’th element from a list.
%%% eg
%%%     erl99problems:p16([a,b,c,d,e,f,g,h,i,k], 3).
%%%     > [a,b,d,e,g,h,k]
%%% @end

%--- delete this line and write your code for p16 here ---%

%%% @doc p17 Split a list into two parts; the length of the first part is given. 
%%% Do not use any Built In Functions (BIF).
%%% eg 
%%%     erl99problems:p17([1,2,3,4,5], 2).
%%%     > {[1,2],[3,4,5]}
%%% @end

%--- delete this line and write your code for p17 here ---%

%%% @doc p18 Extract a slice from a list.
%%% eg
%%%     erl99problems:p18([a,b,c,d,e,f,g,h,i,k], 3, 7).
%%%     > [c,d,e,f,g]
%%% @end

%--- delete this line and write your code for p18 here ---%

%%% @doc p19: Rotate a list N places to the left.
%%% eg
%%%     erl99problems:p19([a,b,c,d,e,f,g,h], 3).
%%%     > [d,e,f,g,h,a,b,c]
%%%     erl99problems:p19([a,b,c,d,e,f,g,h], -2).
%%%     > [g,h,a,b,c,d,e,f]
%%% @end

%--- delete this line and write your code for p19 here ---%

%%% @doc p20: Remove the K’th element from a list
%%% eg
%%%     erl99problems:p20([1,2,3], 2).
%%%     > [1,3]
%%% @end

%--- delete this line and write your code for p20 here ---%

%%% @doc p21: Insert an element at a given position into a list.
%%% eg
%%%     erl99problems:p21([1,2,3], 5, 2).
%%%     > [1,2,5,3]
%%% @end

%--- delete this line and write your code for p21 here ---%

%%% @doc p22: Create a list containing all integers within a given range.
%%% eg
%%%     erl99problems:p22(9, 4).
%%%     > [9,8,7,6,5,4]
%%%     erl99problems:p22(4,9).
%%%     > [4,5,6,7,8,9]
%%% @end

%--- delete this line and write your code for p22 here ---%

%%% @doc p23: Extract a given nubmer of randomly selected elements from a list.
%%% eg
%%%     erl99problems:p23([1,2,3,4,5,6], 3).
%%%     > [1,2,6]
%%% @end

%--- delete this line and write your code for p23 here ---%

%%% @doc p24: Lotto: Draw N diference random numbers from the set 1..M. The selected numbers shall be returned in a list.
%%% eg
%%%     erl99problems:p24(6, 49).
%%%     > [23, 1, 17,33,21,37]
%%% @end

%--- delete this line and write your code for p24 here ---%

%%% @doc p25: Generate a random permutation of the elements of a list.
%%% eg
%%%     erl99problems:p25([a,b,c,d,e,f]).
%%%     > [e,d,b,c,a,f]
%%% @end

%--- delete this line and write your code for p25 here ---%
