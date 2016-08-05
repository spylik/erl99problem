%% =====================================================================================
%% BS04: Разобрать XML­документ без атрибутов:
%% Пример:
%% 1> BinXML = <<"<start><item>Text1</item><item>Text2</item></start>">>. 
%% <<"<start><item>Text1</item><item>Text2</item></start>">>
%% 2> bs04:decode_xml(BinXML).
%% {<<"start”>>, [], [
%% {<<"item”>>, [], [<<"Text1">>]},
%% {<<"item”>>, [], [<<"Text2">>]} ]}
%% =====================================================================================
-module(bs04).

-include_lib("eunit/include/eunit.hrl").

-export([
		decode_xml/1
	]).

decode_xml(BinXML) ->
	decode_xml(BinXML,waiting_data,[],[],[],[],0,0).

%TODO: we can make some recursion optimisation - just need to add LastOpenTag and try to match directly till </LastTag> with size checking.

decode_xml(<<"</",Rest/binary>>, CState, _TempTag, OpenTagsList, TempValue, Result, Level, OldLevel) ->
	decode_xml(Rest, closing_tag,[],OpenTagsList,TempValue,Result,Level,OldLevel);

decode_xml(<<"<",Rest/binary>>, CState, _TempTag, OpenTagsList, TempValue, Result, Level, OldLevel) ->
	decode_xml(Rest, opening_tag,[],OpenTagsList,TempValue,Result,Level,OldLevel);

decode_xml(<<">",Rest/binary>>, closing_tag, _TempTag, OpenTagsList, TempValue, Result, Level, OldLevel) ->
	[H|T] = OpenTagsList,
	case Result of
		[] when TempValue =:= [] ->
			decode_xml(Rest, waiting_data, [], T, [], [{list_to_binary(p05:reverse(H)),[],[p05:reverse(TempValue)]}],Level-1,Level);
		[] ->
			decode_xml(Rest, waiting_data, [], T, [], [{list_to_binary(p05:reverse(H)),[],[list_to_binary(p05:reverse(TempValue))]}],Level-1,Level);
		_Real when TempValue =:= [], OldLevel =:= Level ->
			decode_xml(Rest, waiting_data, [], T, [], [{list_to_binary(p05:reverse(H)),[]}|Result],Level-1,Level);
		_Resl when TempValue =:= [], OldLevel =/= Level ->
			decode_xml(Rest, waiting_data, [], T, [], [{list_to_binary(p05:reverse(H)),[],Result}],Level-1,Level);
		_Real when OldLevel =:= Level->
			decode_xml(Rest, waiting_data, [], T, [], p05:reverse([{list_to_binary(p05:reverse(H)),[],[list_to_binary(p05:reverse(TempValue))]}|Result]),Level-1,Level);
		_Real when OldLevel =/= Level->
			decode_xml(Rest, waiting_data, [], T, [], [{list_to_binary(p05:reverse(H)),[],[list_to_binary(p05:reverse(TempValue))],Result}],Level-1,Level)
	end;

decode_xml(<<">",Rest/binary>>, opening_tag, TempTag, OpenTagsList, _TempValue, Result, Level, OldLevel) ->
	decode_xml(Rest, waiting_data, [], [TempTag|OpenTagsList], [], Result,Level+1,OldLevel);

decode_xml(<<Data, Rest/binary>>,CurrentState,TempTag,OpenTagsList,TempValue,Result,Level,OldLevel) ->
	case CurrentState of
		waiting_data	->	decode_xml(Rest, CurrentState, [], OpenTagsList, [Data|TempValue], Result, Level,OldLevel);
		opening_tag		->	decode_xml(Rest, CurrentState, [Data|TempTag], OpenTagsList, TempValue, Result, Level,OldLevel);
		closing_tag		->	decode_xml(Rest, CurrentState, [Data|TempTag], OpenTagsList, TempValue, Result,Level,OldLevel)
	end;

decode_xml(<<>>, CState, _TempTag, _OpenTagsList, _TempValue, _Result = [Output], _Level,_OldLevel) -> 
	Output.


% ======================================== test suite ======================================

decode_xml_a_test() -> {<<"start">>, [], [
			{<<"item">>, [], [<<"Text1">>]},
			{<<"item">>, [], [<<"Text2">>]} 
		]}	= decode_xml(<<"<start><item>Text1</item><item>Text2</item></start>">>).
