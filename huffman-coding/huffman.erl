%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Jan 2017 15:18
%%%-------------------------------------------------------------------
-module(huffman).

%%-export([sample/0]).

-compile(export_all).

sample() -> "the quick brown fox jumps over the lazy dog
     this is a sample text that we will use when we build
     up a table we will only handle lower case letters and
     no punctuation symbols the frequency will of course not
     represent english but it is probably not that far off".

text() -> "this is something that we should encode".



test() ->
  Sample = sample(),
  Freq = lists:keysort(2,freq(Sample)),
  Tree = tree(Freq),
  Encode = encode_table(Tree),
  Decode = decode_table(Tree),
  Text = text(),
  Seq = encode(Text, Encode),
   decode(Seq, Decode).

%tree(Sample) -> Freq = freq(Sample).
 % huffman(Freq).

freq(Sample) -> freq(Sample,[]).
freq([], Freq) -> Freq;
freq([Char|Rest], Freq) ->
  [{[Char],Num},RestToCount] = freq(Rest,Char,1,[]),
  freq(RestToCount, Freq++[{[Char],Num}]).

freq([], Char, Num, RestToCount) -> [{[Char],Num},RestToCount];
freq([Char|Rest], Char, Num, RestToCount) ->
    freq(Rest,Char,Num+1,RestToCount);
freq([NewChar|Rest], Char, Num, RestToCount) ->
  freq(Rest, Char, Num, RestToCount++[NewChar]).

tree([{Sample, F} | []]) -> {Sample,F};
tree(Sample) ->
  [{C1, F1}, {C2, F2} | Rest] = lists:keysort(2, Sample),
  tree([{{C1, C2}, F1 + F2} | Rest]);
tree(_Sample) -> na.

encode_table({L,R}) -> encode_table(L,[])++encode_table(R,[]).
encode_table({L,R},Code) -> encode_table(L,Code++[0])++ encode_table(R,Code++[1]);
encode_table(Char,Code) -> [{Char,Code}].
%[{Char,lists:reverse(Code)}].
%encode_table(_Tree) -> na.

decode_table(_Tree) -> na.

encode(Text,Table) -> encode(Text,Table,[]).
encode([],_Table,Result) -> Result;
encode([Char|Rest],Table,Result) -> encode(Rest,Table,Result ++ proplists:get_value([Char],Table)).
%encode(_Text, _Table) -> na.

decode([], _Table) -> [];
decode(Seq, Table) ->
  {Char, Rest} = decode_char(Seq, 1, Table),
  decode(Rest, Table).

decode_char(Seq, N, Table) ->
 % decode_char(Seq,N,Table,"").

%decode_char(Seq,N,Table,Result)-> decode_char("",Seq,N,Table,Result).

%decode_char(Char,Seq,N,Table,Result)->
  {Code, Rest} = lists:split(N, Seq),
%  [{Char,Code}]= Table,
  case lists:keyfind(Code, 2, Table) of
    {Char,Code}-> {Char,Rest};
      %decode_char(Rest,Table,Result ++ [Char]);
false ->
decode_char(Seq,N+1,Table)
end.

%decode(_Seq, _Table) -> na.

