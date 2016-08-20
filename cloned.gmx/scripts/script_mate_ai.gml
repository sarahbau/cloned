//var fighter=global.fighter_obj[argument0].fighter_name;
var fighter = global.player1
var ai_array;
var ai_fitness_array;
var num_to_carry_over = 20;

if(argument0==0) {
    ai_array=global.p1_ai_array;
    ai_fitness_array = global.ai_fitness_1;
//    show_message("mating for player 1 - " + fighter);
} else if(argument0==1) {
    ai_array=global.p2_ai_array;
    ai_fitness_array = global.ai_fitness_2;
//    show_message("mating for player 2 - " + fighter);
}

var temp;
var temp_sort_grid;
var array_length = array_length_1d(ai_fitness_array);

//show_message("sorting");

for(var i=0;i<array_length;i++) {
    ai_fitness_array[i] += 1;
}

for(var i=0;i<array_length;i++) {
    for(var j = i + 1; j < array_length; j += 1 ) {
        if(ai_fitness_array[j]>ai_fitness_array[i]) {
            temp=ai_fitness_array[j];
            ai_fitness_array[j]=ai_fitness_array[i];
            ai_fitness_array[i]=temp;
            
            temp_sort_grid=ai_array[j];
            ai_array[j]=ai_array[i];
            ai_array[i]=temp_sort_grid;
        }
    }
}

//var message = "Fitness:";
//for(var i = 0;i<arrayLength;i++) {
//    message = message + "  " + string(ai_fitness_array[i]);
//}
//show_debug_message(message);

var temp_array;
var temp_grid;
var pos=0;


/**** New Version ****/
var total_fit = 0;
var top_fit = 0;
for(var i=0; i<array_length; i++) {
    total_fit += ai_fitness_array[i];
    
    //Copy the best num_to_carry_over to the next generation
    if(i<num_to_carry_over) {
        temp_array[i] = ai_array[i];
        top_fit += ai_fitness_array[i];
    }
}
global.fitness1 = total_fit;
global.top20fit1 = top_fit;
global.topfit1 = ai_fitness_array[0];

// Normalize the fitnesses
for(var i=0; i<array_length; i++) {
    ai_fitness_array[i] = ai_fitness_array[i]/total_fit;
}

// Mate the top 80 with random
for(var i=0; i<array_length-num_to_carry_over; i++) {
    var r = random(1);
    //show_message("Looking for fitness better than " + string(r));
    var fit_sum = 0;
    for(var j=array_length-1; j>=0; j--) {
        fit_sum += ai_fitness_array[j];
        if((fit_sum >= r)) {
            temp_array[i+num_to_carry_over] = script_new_mating_helper(ai_array[i], ai_array[j]);
            break;
        }
    }
}


/**** Old version 

//Mate the best 10 with the second best 10 - yields 10 offspring
//Copy best 10 to next generation - yields 10
for(var a=0;a<10;a++) {
    temp_array[pos]=ai_array[a];
    pos++;
    temp_grid=script_new_mating_helper(ai_array[a], ai_array[a+10], a, a+10, pos);
    temp_array[pos]=temp_grid;
    pos++;
}



//Mate 1-80 with random - yields 80 offspring
for(var b=0;b<array_length_1d(ai_array)-20;b++) {
    var second = irandom(array_length_1d(ai_array)-1);
    temp_grid=script_new_mating_helper(ai_array[b], ai_array[second], b, second, pos);
    temp_array[pos]=temp_grid;
    pos++;
}

****************/


//Shuffle the array so the best fighters don't always fight the best.
var l=ds_list_create()
for (var arr=0; arr<array_length_1d(temp_array); arr+=1) ds_list_add(l,temp_array[arr])
ds_list_shuffle(l)
for (var arr2=0; arr2<array_length_1d(temp_array); arr2+=1) temp_array[arr2]=ds_list_find_value(l,arr2)
ds_list_destroy(l)



//for(var i=0;i<array_length_1d(temp_array);i++) {
//    for(var j=0;j<ds_grid_height(temp_array[i]);j++) {
//        var message = string(j) + ":";
//        for(var k=0;k<ds_grid_width(temp_array[i]);k++) {
//            message = message + "  " + string(ds_grid_get(temp_array[i], k,j));
//        }
//        show_debug_message(message);
//    }
//}

script_save_ai_generation(fighter, temp_array);

return temp_array;

