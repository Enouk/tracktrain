
-record(user, {id, name, email}).
-record(user_figure, {user_id, day}).

-record(training_day, {user_id, day, passes=[]}).
-record(training_pass, {training_item, duration}).
-record(training_item, {id, name, calories, unit}).
	   
-record(food_day, {user_id, day, meals=[]}).
-record(food_meal, {food_item, time, amount}).
-record(food_item, {id, name, calories, fat, protein, carbohydrate, unit, properties=[]}).