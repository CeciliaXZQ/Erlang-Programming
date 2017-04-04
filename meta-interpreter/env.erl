%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. Feb 2017 14:14
%%%-------------------------------------------------------------------
-module(env).

-compile(export_all).

new()->[].

add(Id, Str, Env)-> [{Id, Str}|Env].

lookup(Id, Env)->
  case lists:keyfind(Id, 1, Env) of
    {Id,Str}->{Id, Str};
  false -> false
end.