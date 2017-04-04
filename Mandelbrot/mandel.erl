%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Feb 2017 21:39
%%%-------------------------------------------------------------------
-module(mandel).

-export([demo/0]).

mandelbrot(Width, Height, X, Y, K, Depth) ->
  Trans = fun(W, H) ->
    cmplx:new(X + K*(W-1), Y - K*(H-1))
          end,
  rows(Width, Height, Trans, Depth, []).

rows(_, 0, _, _, Rows)->
  Rows;
rows(Width, Height, Trans, Depth, Rows)->
Line=line(Width, Height, Trans, Depth, []),
  rows(Width, Height-1, Trans, Depth, [Line|Rows]).



line(0, _, _, _, Line)->
  Line;
line(Width, Height, Trans, Depth, Line)->
  PixelDepth = brot:mandelbrot(Trans(Width, Height), Depth),
  PixelColor = color:convert(PixelDepth, Depth),
  line(Width - 1, Height, Trans, Depth, [PixelColor|Line]).



demo() ->
  small(-2.6,1.2,1.6).

small(X,Y,X1) ->
  Width = 960,
  Height = 540,
  K = (X1 - X)/Width,
  Depth = 64,
  T0 = now(),
  Image = mandelbrot(Width, Height, X, Y, K, Depth),
  T = timer:now_diff(now(), T0),
  io:format("picture generated in ~w ms~n", [T div 1000]),
  ppm:write("small2.ppm", Image).