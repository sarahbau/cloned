var inc_generation = false;

if(global.training_mode && !global.ai_train_start) {
    if(controller_obj[0].is_ai) {
        script_ai_fitness(fighter_obj[0], global.p1_ai_array, 0);
        if(global.ai_training_instance==array_length_1d(global.p1_ai_array)-1) {
            global.p1_ai_array = script_mate_ai(0);
            inc_generation=true;
        }
    }
    if(controller_obj[1].is_ai) {
        script_ai_fitness(fighter_obj[1], global.p2_ai_array, 1);
        if(global.ai_training_instance==array_length_1d(global.p2_ai_array)-1) {
            //global.p2_ai_array = script_mate_ai(1);
            inc_generation=true;
        }
    }
}

if(inc_generation || global.ai_train_start) {
    if(!global.ai_train_start) show_debug_message(global.player1 + "    " + string(wins[0]) + "    " + string(global.fitness1) + "    " + string(global.top20fit1*5) + "    " + string(global.topfit1*100));
    global.ai_train_start = false;
    var f = ds_list_create();
    ds_list_add(f, "wukong");
    ds_list_add(f, "jibbers");
    ds_list_add(f, "panda");
    ds_list_add(f, "bahamut");
    ds_list_add(f, "bahamut2");
    //ds_list_shuffle(f);
    global.player1 = ds_list_find_value(f,global.ai_training_generation%5);
    ds_list_delete(f,0);
    
    //Temporarily setting player2 to always be Jibbers
    //global.player2 = ds_list_find_value(f,0);
    global.player2 = global.player1;
    
    
    ds_list_destroy(f);
    global.wins[0]=0;
    global.wins[1]=0;
    script_read_ai_generation(global.player1, global.p1_ai_array);
    
    //Temporarily setting player2 to use manually built AI
    //script_read_ai_generation(global.player2, global.p2_ai_array);
    global.p2_ai_array = script_default_ai_grid();
    
    global.ai_training_instance=0;
    global.ai_training_generation++;
}

if(global.training_mode) {
    global.ai_training_instance++;
    global.ai_training_total++;
}

script_room_select();

