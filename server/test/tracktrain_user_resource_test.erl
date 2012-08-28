%% Author: marcus
%% Created: 24 aug 2012
-module(tracktrain_user_resource_test).

%%
%% Include files
%%

-include("tracktrain.hrl").
-include("jsonerl.hrl").

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

setup()  -> tracktrain:start(), inets:start().
cleanup(_) -> tracktrain:stop(), inets:stop().

all_test_() ->
	{ setup,
	  fun setup/0,
	  fun cleanup/1,
	  ?_test(
	  begin
		  ?assertEqual(?ADAM, ?json_to_record(user, get_single()))
	  end
	  )
	}.

get_single() ->
	{ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request("http://localhost:8000/api/user/1"),
	Body.