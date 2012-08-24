%% Author: marcus
%% Created: 24 aug 2012
-module(tracktrain_user_resource_test).

%%
%% Include files
%%

-include("tracktrain.hrl").
-include("jsonerl.hrl").

-include_lib("eunit/include/eunit.hrl").



get_all_test() ->
	ok = tracktrain_user_repo:get_all().
	

