%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Feb 2017 15:13
%%%-------------------------------------------------------------------
-module(chopstick).

-compile(export_all).

start() ->
  spawn_link(fun() -> init() end).

init() ->
  available().


% both chopsticks in same time:
%%available() ->
%%  receive
%%    %%first solution
%%    {request, Pid}->
%%   %   io: write("reqeust sent"),
%%      Pid ! ok,
%%      gone();
%%     quit -> ok
%%end.
%%
%%gone() ->
%%%%keeptrack: gone(Ref)->
%%  receive
%%  return -> available();
%%quit -> ok
%%end.
%%
%%request(Left, Right, Timeout) ->
%%  Left ! {request, self()},
%%  Right ! {request, self()},
%%  granted(Timeout).
%%
%%granted(Timeout) ->
%%  receive
%%    ok ->
%%      receive
%%        ok ->
%%          ok
%%      end
%%  after
%%    Timeout ->
%%      no
%%  end.

%one by one
available() ->
  receive
    %%first solution
    {request, Pid}->
   %   io: write("reqeust sent"),
      Pid ! ok,
     gone();
     quit -> ok
end.

gone() ->
  receive
  return -> available();
quit -> ok
end.

request(Pid, Timeout) ->
  Pid ! {request, self()},
  granted(Timeout).

granted(Timeout) ->
  receive
    ok ->
          ok
  after
    Timeout ->
      no
  end.

return(Pid)->
  Pid!return.

terminate(Stick) ->
  Stick ! quit.