%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Feb 2017 14:57
%%%-------------------------------------------------------------------
-module(brot).

-compile(export_all).

mandelbrot(C, M) ->
  Z0 = cmplx:new(0,0),
I = 0,
test(I, Z0, C, M).

test(_, _, _, 0)->0;
test(I, Z0, C, M) ->
  Z = cmplx:add(cmplx:sqr(Z0), C), % Zn+1 = Zn^2 + c
  Abs = cmplx:abs(Z0),
  if
    Abs >= 2 -> I;
    true -> test(I+1, Z, C, M-1)
  end.
