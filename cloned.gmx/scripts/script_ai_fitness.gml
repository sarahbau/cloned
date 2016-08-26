var fighter = argument0;
var ai_array = argument1;
var player = argument2;
var opponent = fighter.opponent;

var fitness=(fighter.hp/fighter.max_hp)-(opponent.hp/opponent.max_hp);
var array_length = array_length_1d(ai_array);

//show_debug_message("ai_training_instance = " + string(global.ai_training_instance) + "; array_length = " + string(array_length));
if(player==0) global.ai_fitness_1[ai_training_instance%array_length] += fitness;
if(player==1) global.ai_fitness_2[ai_training_instance%array_length] += fitness;


