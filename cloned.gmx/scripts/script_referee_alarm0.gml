var inc_generation = false;

if(global.training_mode && !global.ai_train_start) {
    if(controller_obj[0].is_ai) {
    var pop_size = array_length_1d(global.p1_ai_array);
    //show_debug_message("pop_size is " + string(pop_size));
        script_ai_fitness(fighter_obj[0], global.p1_ai_array, 0);
        if(global.ai_training_instance%pop_size == pop_size-1) {
            global.ai_opponent++;
            global.player2 = ds_list_find_value(global.fighter_list, global.ai_opponent%5);
            if(global.ai_opponent%5 == 0) {
                global.p1_ai_array = script_mate_ai(0);
                inc_generation=true;
            }
        }
    }
}

if(inc_generation || global.ai_train_start) {
    if(!global.ai_train_start) show_debug_message(global.player1 + "    " + string(wins[0]) + "    " + string(global.fitness1) + "    " + string(global.top20fit1) + "    " + string(global.topfit1*global.ai_pop));
    global.ai_train_start = false;
    
    global.player1 = ds_list_find_value(global.fighter_list, global.ai_training_generation%5);
    
    global.wins[0]=0;
    global.wins[1]=0;
    script_read_ai_generation(global.player1, global.p1_ai_array);
    
    //Temporarily setting player2 to always be Jibbers
    //global.player2 = ds_list_find_value(f,0);
    if(global.ai_training_generation%5 == 0) {
        global.player2 = global.player1;
        /*
        if(global.ai_training_generation != 0) {
            // Shrink population by 1
            var ai_array = global.p1_ai_array;
            var array_length = array_length_1d(ai_array);
            var temp_array;
            for(var i=0; i<array_length-1; i++) {
                temp_array[i] = ai_array[i];
            }
            global.p1_ai_array = temp_array;
            show_debug_message("AI Array is now size " + string(array_length_1d(global.p1_ai_array)));
        }
        */
    }
    
    //Temporarily setting player2 to use manually built AI
    //script_read_ai_generation(global.player2, global.p2_ai_array);
    global.p2_ai_array = script_default_ai_grid();
    
    global.ai_training_instance=0;
    global.ai_training_generation++;
} else if(global.training_mode) {
    global.ai_training_instance++;
    global.ai_training_total++;
    if(global.player1 == global.player2) global.ai_fitness_1[ai_training_instance%global.ai_pop] = 0;
}

script_room_select();

