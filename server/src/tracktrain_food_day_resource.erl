-module(tracktrain_food_day_resource).

-export([init/1, content_types_provided/2, resource_exists/2, to_json/2]).

-include_lib("webmachine/include/webmachine.hrl"). 

init([]) -> {ok, []}.

content_types_provided(ReqData, Context) ->
	 {[{"application/json", to_json}], ReqData, Context}.
    

resource_exists(ReqData, Context) ->
	case wrq:disp_path(ReqData) of
		"" -> 
			All = tracktrain_food_day_repo:get_all(), 
			{true, ReqData, All};
		FoodDayId -> 
			case tracktrain_food_day_repo:get(FoodDayId) of 
				{ok, [FoodDay]} -> {true, ReqData, [FoodDay]};
				not_found -> {false, ReqData, Context}
			end
	end.
to_json(_ReqData, []) ->
	{"", _ReqData, []};

to_json(ReqData, Resources) ->
	{ Resources, ReqData, Resources}.