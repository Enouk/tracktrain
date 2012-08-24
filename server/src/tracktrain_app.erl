-module(tracktrain_app).

-behaviour(application).

%% Application callbacks
-export([start/1, start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start([]) ->
	tracktrain_sup:start_link().

start(_StartType, _StartArgs) ->
    tracktrain_sup:start_link().

stop(_State) ->
    ok.
