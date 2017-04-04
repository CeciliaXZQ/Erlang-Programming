%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Feb 2017 16:43
%%%-------------------------------------------------------------------
-module(color).

-compile(export_all).
convert(Depth, Max) ->

  A = (Depth/Max)*4,
  X = trunc(A),
  Y = trunc(255*(A - X)),

  case X of
    0 -> {Y, 0, 0};
    1 -> {255, Y, 0};
    2 -> {255 - Y, 255, 0};
    3 -> {0, 255, Y};
    4 -> {0, 255 - Y, 255}
  end.