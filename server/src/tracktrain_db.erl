%% Author: marcus
%% Created: 24 aug 2012
%% Description: TODO: Add description to db
-module(tracktrain_db).

%%
%% Include files
%%
-include("tracktrain.hrl").

%%
%% Exported Functions
%%
-export([init/0, stop/0, create_tables/0, write/1, read/2, read_all/1, delete/2, reset/0]).

%%
%% API Functions
%%

%% @doc init the database and create the schema and the tables.
init() -> 
	case mnesia:create_schema([node()]) of
		{error, {_Node, {already_exists, _Node}}} ->
			mnesia:start(),
			wait_for_tables(),
			{ok, tables_exist};
		ok ->
			mnesia:start(),
			create_tables(),
			wait_for_tables(),
			{ok, tables_created}
	end.

stop() ->
	mnesia:stop().

wait_for_tables() ->
	mnesia:wait_for_tables([user,user_figure,training_day,training_pass,training_item,food_day,food_meal, food_item], 1000).
	
create_tables() ->
	mnesia:create_table(user, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, user)}]),
	mnesia:create_table(user_figure, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, user_figure)}]),
	
	mnesia:create_table(training_day, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, training_day)}]),
	mnesia:create_table(training_pass, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, training_pass)}]),
	mnesia:create_table(training_item, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, training_item)}]),
	
	mnesia:create_table(food_day, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, food_day)}]),
	mnesia:create_table(food_meal, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, food_meal)}]),
	mnesia:create_table(food_item, 
						[{disc_copies,[node()]},
						 {attributes, 
						  record_info(fields, food_item)}]).
reset() ->
	clear_table(user),
	clear_table(user_figure),
	clear_table(training_day),
	clear_table(training_pass),
	clear_table(training_item),
	clear_table(food_day),
	clear_table(food_meal),
	clear_table(food_item),
	
	write(?ADAM),
	write(?EVA),
	write(?TR_1_CROSS_FIT),
	write(?ADAM_TR_PASS1),
	write(?ADAM_TR_DAY1),
	write(?FD_1_MILK),
	write(?ADAM_FD_MEAL1),
	write(?ADAM_FD_DAY1).

clear_table(T) ->
	mnesia:clear_table(T).

write(Record) ->
	Fun = fun()-> 
				  mnesia:write(Record)
		  end,
	mnesia:transaction(Fun).

read(Tab, Key) ->
	Fun = fun() ->
				  mnesia:read({Tab, Key})
		  end,
	mnesia:transaction(Fun).

read_all(Tab) ->
  	WildPattern = mnesia:table_info(Tab, wild_pattern),
	Fun = fun() ->
				  mnesia:match_object(WildPattern)
		  end,
	mnesia:transaction(Fun).

match(Match) ->
	Fun = fun() ->
				  mnesia:match_object(Match)
		  end,
	mnesia:transaction(Fun).

delete(Tab, Key) ->
	Fun = fun() ->
				  mnesia:delete({Tab, Key})
		  end,
	mnesia:transaction(Fun).

