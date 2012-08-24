%% Author: marcus
%% Created: 11 aug 2012
%% Description: TODO: Add description to tracktrain_root_resource
-module(tracktrain_root_resource).

-include("tracktrain.hrl").

-export([init/1, content_types_provided/2, resource_exists/2, provide_content/2]).

-record(context, {docroot,fullpath}).

-include_lib("webmachine/include/webmachine.hrl"). 

init([DocRoot]) -> {ok, #context{docroot=DocRoot}}.

content_types_provided(ReqData, Context) ->
    Path = wrq:disp_path(ReqData),
    case Path of
        "" -> {[{"text/html", provide_content}], ReqData, Context};
        _ -> {[{webmachine_util:guess_mime(Path), provide_content}], ReqData, Context}
    end.

provide_content(ReqData, Context) ->
    {ok, Value} = file:read_file(Context#context.fullpath),
    {Value, ReqData, Context}.

resource_exists(ReqData, Context) ->
    case wrq:disp_path(ReqData) of
        "" -> {true, ReqData, Context#context{fullpath=
                      filename:join([Context#context.docroot, "index.html"])}};
        Path -> 
            case mochiweb_util:safe_relative_path(Path) of
                undefined -> {false, ReqData, Context};
                SafePath ->
                    FPath = filename:join([Context#context.docroot, SafePath]),
                    case filelib:is_regular(FPath) of
                        true -> {true, ReqData, Context#context{fullpath=FPath}};
                        _ -> {false, ReqData, Context}
                    end
            end
    end.

