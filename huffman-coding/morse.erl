%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Jan 2017 14:19
%%%-------------------------------------------------------------------
-module(morse).


-export([]).
%%% The codes that you should decode:

base() ->
  ".- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... ".


rolled() ->
  ".... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- ".


%%% The decoding tree.

decode_table() ->
  {node,na,
    {node,116,
      {node,109,
        {node,111,
          {node,na,{node,48,nil,nil},{node,57,nil,nil}},
          {node,na,nil,{node,56,nil,{node,58,nil,nil}}}},
        {node,103,
          {node,113,nil,nil},
          {node,122,
            {node,na,{node,44,nil,nil},nil},
            {node,55,nil,nil}}}},
      {node,110,
        {node,107,{node,121,nil,nil},{node,99,nil,nil}},
        {node,100,
          {node,120,nil,nil},
          {node,98,nil,{node,54,{node,45,nil,nil},nil}}}}},
    {node,101,
      {node,97,
        {node,119,
          {node,106,
            {node,49,{node,47,nil,nil},{node,61,nil,nil}},
            nil},
          {node,112,
            {node,na,{node,37,nil,nil},{node,64,nil,nil}},
            nil}},
        {node,114,
          {node,na,nil,{node,na,{node,46,nil,nil},nil}},
          {node,108,nil,nil}}},
      {node,105,
        {node,117,
          {node,32,
            {node,50,nil,nil},
            {node,na,nil,{node,63,nil,nil}}},
          {node,102,nil,nil}},
        {node,115,
          {node,118,{node,51,nil,nil},nil},
          {node,104,{node,52,nil,nil},{node,53,nil,nil}}}}}}.


%%% The codes in an ordered list.

codes() ->
  [{32,"..--"},
    {37,".--.--"},
    {44,"--..--"},
    {45,"-....-"},
    {46,".-.-.-"},
    {47,".-----"},
    {48,"-----"},
    {49,".----"},
    {50,"..---"},
    {51,"...--"},
    {52,"....-"},
    {53,"....."},
    {54,"-...."},
    {55,"--..."},
    {56,"---.."},
    {57,"----."},
    {58,"---..."},
    {61,".----."},
    {63,"..--.."},
    {64,".--.-."},
    {97,".-"},
    {98,"-..."},
    {99,"-.-."},
    {100,"-.."},
    {101,"."},
    {102,"..-."},
    {103,"--."},
    {104,"...."},
    {105,".."},
    {106,".---"},
    {107,"-.-"},
    {108,".-.."},
    {109,"--"},
    {110,"-."},
    {111,"---"},
    {112,".--."},
    {113,"--.-"},
    {114,".-."},
    {115,"..."},
    {116,"-"},
    {117,"..-"},
    {118,"...-"},
    {119,".--"},
    {120,"-..-"},
    {121,"-.--"},
    {122,"--.."}].

test() ->
  Base = base(),
  Rolled = rolled(),
  Tree = decode_table(),
  decode(Base, Tree),
  decode(Rolled, Tree).

% Use the encoding tree to decode the message
decode(Seq, Tree) ->
  decode(Seq, Tree, Tree).
decode([$- | Seq], {node, _, Left, _}, Tree) ->
  decode(Seq, Left, Tree);
decode([$. | Seq], {node, _, _, Right}, Tree) ->
  decode(Seq, Right, Tree);
decode([_ | Seq], {node, Char, _, _}, Tree) ->
  case Seq of
    [] -> [Char];
    _ -> [Char | decode(Seq, Tree, Tree)]
  end.