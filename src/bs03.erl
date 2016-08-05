%% =====================================================================================
%% BS03: Разделить строку на части, с явным указанием разделителя:
%% Пример:
%% 1> BinText = <<”Col1­:­Col2­:­Col3­:­Col4­:­Col5”>>. 
%% <<”Col1­:­Col2­:­Col3­:­Col4­:­Col5”>>
%% 2> bs03:split(BinText, “­:­”).
%% [<<”Col1”>>, <<”Col2”>>, <<”Col3”>>, <<”Col4”>>]
%% =====================================================================================
-module(bs03).

-include_lib("eunit/include/eunit.hrl").

-export([
		split/2
	]).

split(Bin, Delm) ->	
	DelmBin = list_to_binary(Delm),
	DelmSize = byte_size(DelmBin),
	split(Bin, <<>>, [], DelmBin, DelmSize).

split(Bin, Temp, Result, Delm, DelmSize) ->
	Tupple = {Bin,Temp},
	case Tupple of
		{<<Delm:DelmSize/binary, Rest/binary>>, <<>>} -> 
			split(Rest, <<>>, Result, Delm, DelmSize);
		{<<Delm:DelmSize/binary, Rest/binary>>, _} -> 
			split(Rest, <<>>, [Temp|Result], Delm, DelmSize);
		{<<Data, Rest/binary>>, _} -> 
			split(Rest, <<Temp/binary, Data>>, Result, Delm, DelmSize);
		{<<>>, <<>>} ->	
			p05:reverse(Result);
		{<<>>, _} -> p05:reverse([Temp|Result])
	end.

% ======================================== test suite ======================================

split_a_test() -> 
	[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] = split(<<"Col1­:­Col2­:­Col3­:­Col4­:­Col5">>, "­:­").
split_b_test() -> 
	[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] = split(<<"­:­Col1­:­Col2­:­Col3­:­Col4­:­Col5">>, "­:­").
split_c_test() -> 
	[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] = split(<<"­:­Col1­:­Col2­:­Col3­:­Col4­:­Col5­:­">>, "­:­").
split_d_test() -> 
	[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] = split(<<"Col1­:­Col2­:­Col3­:­Col4­:­Col5">>, "­:­").
