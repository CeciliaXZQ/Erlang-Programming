%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Feb 2017 14:19
%%%-------------------------------------------------------------------
-module(cmplx).

-compile(export_all).

new(X, Y)-> {X,Y}.
add(A, B)->
  case A of
    {X1,Y1} ->
      case B of
        {X2,Y2}->
          {X1+X2,Y1+Y2}
end
end.

sqr(A)->
  case A of
    {X,Y}  ->
      {X*X-Y*Y,2*X*Y}
end.

abs(A)->
  case A of
    {X,Y} ->
      math:sqrt(X*X+Y*Y)
end.