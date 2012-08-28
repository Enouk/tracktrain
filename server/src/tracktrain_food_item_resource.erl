%% Author: marcus
%% Created: 26 aug 2012
%% Description: TODO: Add description to tracktrain_food_item_resource
-module(tracktrain_food_item_resource).

-include("tracktrain.hrl").
-include("jsonerl.hrl").

-export([init/1, content_types_provided/2, resource_exists/2, to_json/2]).

-include_lib("webmachine/include/webmachine.hrl"). 

init([]) -> {ok, []}.

content_types_provided(ReqData, Context) ->
	 {[{"application/json", to_json}], ReqData, Context}.
    
resource_exists(ReqData, Context) ->
	case wrq:disp_path(ReqData) of
		"" -> 
			{ok, All} = tracktrain_user_repo:get_all(),
			{true, ReqData, All};
		UserId -> 
			case tracktrain_user_repo:get(UserId) of 
				{ok, User} -> {true, ReqData, [User]};
				not_found -> {false, ReqData, Context}
			end
	end.
to_json(_ReqData, []) ->
	{"", _ReqData, []};

to_json(ReqData, Users) ->
	{ ?list_records_to_json(user, Users), ReqData, Users}.


