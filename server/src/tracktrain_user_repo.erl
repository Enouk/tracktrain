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

get(UserId) ->
	case tracktrain_db:read(user, UserId) of 
		{atomic, [User]} -> {ok, User};
		{atomic, []} -> not_found
	end.


get_all() ->
	{atomic, Users} = tracktrain_db:read_all(user),
	{ok, Users}.




%%
%% Local Functions
%%

