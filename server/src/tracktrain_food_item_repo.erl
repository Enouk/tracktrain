%% Author: marcus
%% Created: 26 aug 2012
%% Description: TODO: Add description to tracktrain_food_item_resource
-module(tracktrain_food_item_repo).

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
get(ItemId) ->
	case tracktrain_db:read(food_item, ItemId) of
		{atomic, [Item]} -> {ok, Item};
		{atomic, []} -> not_found
	end.

get_all() ->
	{atomic, Items} = tracktrain_db:read_all(food_item),
	{ok, Items}.