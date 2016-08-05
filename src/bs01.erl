%% =====================================================================================
%% BS01: Извлечь из строки первое слово:
%% Пример:
%% 1> BinText = <<”Some text”>>. 
%% <<”Some Text”>>
%% 2> bs01:first_word(BinText). 
%% <<”Some”>>
%% =====================================================================================
-module(bs01).

-include_lib("eunit/include/eunit.hrl").

-export([
		first_word/1
	]).


first_word(Bin) -> 
	first_word(Bin, <<>>).

first_word(<< " ", _/binary>>, Result) -> 
	Result;

first_word(<<X, Rest/binary>>, Result) -> 
	first_word(Rest, <<Result/binary, X>>);

first_word(<<>>,Result) -> 
	Result.

% ======================================== test suite ======================================

first_word_a_test() -> <<"Some">> = first_word(<<"Some text">>).
