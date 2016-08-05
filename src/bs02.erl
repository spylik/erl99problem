%% =====================================================================================
%% BS02: Разделить строку на слова:
%% Пример:
%% 1> BinText = <<"Text with four words">>.
%% <<"Text with four words">>
%% 2> bs02:words(BinText).
%% [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]
%% =====================================================================================
-module(bs02).

-include_lib("eunit/include/eunit.hrl").

-export([
		words/1
	]).

% in second argument we will keep temporary word, in third - final result
words(Bin) -> words(Bin, <<>>, []).

words(<<" ", Rest/binary>>, Temp, Result) when Temp =/= <<>> -> 
	words(Rest, <<>>, [Temp|Result]);

words(<<" ", Rest/binary>>, Temp, Result) when Temp =:= <<>> ->	
	words(Rest, <<>>, Result);

words(<<Data, Rest/binary>>, Temp, Result) -> 
	words(Rest, <<Temp/binary, Data>>, Result);

words(<<>>, <<>>, Result) -> 
	p05:reverse(Result);

words(<<>>, Temp, Result) -> 
	p05:reverse([Temp|Result]).


% ======================================== test suite ======================================

words_a_test() -> [<<"Text">>, <<"with">>, <<"four">>, <<"words">>] = words(<<"Text with four words">>).
words_b_test() -> [<<"Text">>, <<"with">>, <<"four">>, <<"words">>] = words(<<"Text with four words ">>).
words_c_test() -> [<<"Text">>, <<"with">>, <<"four">>, <<"words">>] = words(<<" Text with four words">>).
words_d_test() -> [<<"Text">>, <<"with">>, <<"four">>, <<"words">>] = words(<<" Text with four words ">>).
