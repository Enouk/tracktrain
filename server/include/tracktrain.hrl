
-record(user, {id, name, email}).
-record(user_figure, {user_id, day}).

-record(training_item, {id, name, calories, unit}).
-record(training_pass, {training_item_id, duration, unit}).
-record(training_day, {user_id, day, passes=[]}).
	   
-record(food_item, {id, name, calories, fat, protein, carbohydrate, unit, properties=[]}).
-record(food_meal, {food_item_id, time, amount, unit}).
-record(food_day, {user_id, day, meals=[]}).

-define(ADAM, #user{id=1, name=list_to_binary("Adam"), email=list_to_binary("Adam@gmail.com")}).
-define(EVA, #user{id=2, name=list_to_binary("Eva"), email=list_to_binary("Eva@gmail.com")}).

-define(TR_1_CROSS_FIT, #training_item{id=1, name=list_to_binary("Cross fit"), calories=600, unit=hour}).

-define(ADAM_TR_PASS1, #training_pass{duration=30, unit=hour, training_item_id=1}).
-define(ADAM_TR_DAY1, #training_day{user_id=1, day=1, passes=[?ADAM_TR_PASS1]}).

-define(FD_1_MILK, #food_item{id=1, calories=10, carbohydrate=20, fat=30, name=list_to_binary("Milk"), protein=40, unit=liter, properties=[{kalium, 666}]}).

-define(ADAM_FD_MEAL1, #food_meal{food_item_id=1, amount=10, unit=liter}).
-define(ADAM_FD_DAY1, #food_day{user_id=1, day=1, meals=[?ADAM_FD_MEAL1]}).