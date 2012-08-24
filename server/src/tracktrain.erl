%% Author: marcus
%% Created: 11 aug 2012
%% Description: TODO: Add description to tracktrain
-module(tracktrain).

-export([start/0, start_link/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    tracktrain_sup:start_link().

%% @spec start() -> ok
%% @doc Start the tracktrain server.
start() ->
	ensure_started(inets),
    ensure_started(crypto),
    ensure_started(mochiweb),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    ensure_started(webmachine),
    application:start(tracktrain).

%% @spec stop() -> ok
%% @doc Stop the tracktrain server.
stop() ->
    Res = application:stop(webmachine_demo),
    application:stop(webmachine),
    application:stop(mochiweb),
    application:stop(crypto),
    Res.