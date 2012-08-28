-module(tracktrain_app).

-behaviour(application).

%% Application callbacks
-export([start/1, start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start([]) ->
	tracktrain_db:init(),
	tracktrain_sup:start_link().

start(_StartType, _StartArgs) ->
	start([]).

stop(_State) ->
    ok.
