%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. Feb 2017 15:10
%%%-------------------------------------------------------------------
-module(eager).

-compile(export_all).

eval_expr({atm, Id}, _) ->
  {ok, Id};

eval_expr({var, Id}, Env) ->
  case env:lookup(Id,Env) of
false ->error;
    {Id,Str} -> {ok, Str}
end;

eval_expr({cons, E1, E2}, Env) ->
case  eval_expr(E1,Env)of
error -> error;
{ok, X1} ->
   case eval_expr(E2, Env) of
   error -> error;
    {ok,X2} ->
     {ok, {X1,X2}}
    end
end.


eval_match(ignore, _ , Env) ->
{ok, Env};
eval_match({atm, Id}, Id, Env) ->
{ok, Env};

eval_match({var, Id}, Str, Env) ->
case env:lookup(Id,Env) of
false ->
{ok, env:add(Id,Str,Env)};
{Id, Str} -> {ok, Env};
{Id, _} -> fail
end;

eval_match({cons, E1, E2}, {S1,S2}, Env) ->
case eval_match(E1, S1, Env) of
fail -> fail;
{ok, Env2} ->
eval_match(E2, S2, Env2)
end;

eval_match(_, _, _) -> fail.

eval_seq([Exp], Env) ->
  eval_expr(Exp,Env);
eval_seq([{match, Ptr, Exp}|Seq], Env) ->
  case eval_expr(Exp,Env) of
error -> error;
{ok, Str}  ->
  case eval_match(Ptr, Str, Env) of
               fail -> error;
               {ok, Env2} ->eval_seq(Seq, Env2)
  end
end.

 eval(Seq) -> eval_seq(Seq, env:new()).


eval_case({switch,Exp,Clauses}, Env)->
  case eval_expr(Exp,Env) of
      false-> error;
    {ok,Str}->eval_clause(Str,Clauses,Env)

end.

eval_clause(Str,[{Ptr, Seq}|[]],Env)->
  case eval_match(Ptr,Str,Env) of
    {ok,Env2}->eval_seq([Seq], Env2);
    fail-> undefine
  end;

eval_clause(Str,[{Ptr, Seq},';'|Rest],Env)->
  case eval_match(Ptr,Str,Env) of
    {ok,Env2}->eval_seq([Seq], Env2);
    fail->eval_clause(Str,Rest,Env)
end.