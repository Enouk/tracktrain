%% Author: marcus
%% Created: 12 aug 2012
%% Description: TODO: Add description to tracktrain_user_repo
-module(tracktrain_user_repo).

%%
%% Include files
%%
-include("tracktrain.hrl").

%%
%% Exported Functions
%%
-export([get_all/0, get/1]).

%%
%% API Functions
%%
get_all() ->
	{ok, [#user{id=1, name=list_to_binary("Apa")}, 
		  #user{id=2, name=list_to_binary("Banan")}]}.
  
get(UserId) ->
	case UserId of
		"kalle" -> {ok, #user{id=10, name=list_to_binary("Kalle")}};
		_ -> not_found
	end.


%%
%% Local Functions
%%

