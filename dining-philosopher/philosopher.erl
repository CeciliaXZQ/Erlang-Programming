%%%-------------------------------------------------------------------
%%% @author ceciliaX
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Feb 2017 11:14
%%%-------------------------------------------------------------------
-module(philosopher).

-compile(export_all).

-define(Timeout,1000).

%%sleep(T,D)->
%%timer:sleep(T + random:uniform(D)).

% both chopsticks in same time:
%%start(Hungry,Right,Left,Name,Ctrl)->
%%  {A, B, C} = now(),
%%  spawn_link(fun() ->
%%  %  random:seed(exsplus,{Seed,Seed,Seed}),
%%   % dreaming(Hungry, Right, Left, Name, Ctrl) end),
%%    Gui = gui:start(Name),
%%    random:seed(A, B, C),
%%    eat(Hungry, Right, Left, Name, Ctrl,Gui) end),
%%    io:format("~s spawned!~n", [Name]).
%%
%%eat(0, _, _, _, Ctrl,Gui) ->
%%  Gui ! stop,
%%  Ctrl ! done;
%%
%%eat(Hungry, Right, Left, Name, Ctrl,Gui) ->
%%  Gui ! waiting,
%%
%% sleep(1000, 5000),
%%  Chopsticks = chopstick:request(Left, Right, 1000),
%%   Gui!enter,
%%
%%  case Chopsticks of
%%    ok ->
%%      Remaining = Hungry - 1,
%%      Gui! leave,
%%      io:format("~s received two chopsticks~n", [Name]),
%%      sleep(1000, 5000),
%%      chopstick:return(Left),
%%      chopstick:return(Right),
%%      %io:fwrite("~s done, ~w remaining~n", [Name, Remaining]),
%%      io:fwrite("~s done, ~w remaining~n", [Name, Remaining]),
%%      eat(Remaining, Right, Left, Name, Ctrl,Gui);
%%    no ->
%%      chopstick:return(Left),
%%      io:fwrite("~s dropped left~n", [Name]),
%%      chopstick:return(Right),
%%      io:fwrite("~s dropped right~n", [Name]),
%%      eat(Hungry, Right, Left, Name, Ctrl,Gui)
%%  end.


% one by one:
start(Hungry,Right,Left,Name,Ctrl)->
 % {A, B, C} = now(),
  %random:seed(A, B, C),
  spawn_link(fun() ->init(Hungry,Right,Left,Name,Ctrl)end).

init(Hungry,Right,Left,Name,Ctrl)->
  Gui=gui:start(Name),
  dreaming(Hungry,Right,Left,Name,Ctrl,Gui).

dreaming(0,_Left,_Right,_,Ctrl,Gui)->
  Gui!stop,
  Ctrl!done;

dreaming(Hungry,Right,Left,Name,Ctrl,Gui)->
  io:fwrite("~s dreaming ~n", [Name]),
  timer:sleep(1000),
  %sleep(1000, 500),
  waiting(Hungry,Left,Right,Name,Ctrl,Gui).

waiting(Hungry,Left,Right,Name,Ctrl,Gui)->
  Gui!waiting,
  io:fwrite("~s waiting - ~w to go ~n", [Name,Hungry]),
  case chopstick:request(Left,1000) of
   ok  ->
     case chopstick:request(Right,1000) of
         ok->
           io:format("~s received two chopsticks~n", [Name]),
           eating(Hungry,Right,Left,Name,Ctrl,Gui);
       no->
         chopstick:return(Left),
         dreaming(Hungry,Right,Left,Name,Ctrl,Gui)
end;
    no->
      dreaming(Hungry,Right,Left,Name,Ctrl,Gui)
end.

eating(Hungry,Right,Left,Name,Ctrl,Gui)->
  Gui!enter,
  Remaining = Hungry - 1,
  io:fwrite("~s eating ~n", [Name]),
  timer:sleep(1000),
  %sleep(500, 500),
  Gui!leave,
  chopstick:return(Left),
  chopstick:return(Right),
  io:fwrite("~s done, ~w remaining~n", [Name, Remaining]),
  dreaming(Remaining,Right,Left,Name,Ctrl,Gui).


