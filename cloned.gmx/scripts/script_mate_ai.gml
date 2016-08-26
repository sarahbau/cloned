//var fighter=global.fighter_obj[argument0].fighter_name;
var fighter = global.player1
var ai_array;
var ai_fitness_array;
var num_to_carry_over = 4;

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
var array_length = array_length_1d(ai_array);

// Fitness will be on a range from -5 to 5. Update to make it 0 to 10
for(var i=0;i<array_length;i++) {
    ai_fitness_array[i] += 5;
}

// Sort by fitness
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
//total_fit = total_fit/array_length * global.ai_pop;
global.fitness1 = total_fit;
global.top20fit1 = top_fit * (array_length/num_to_carry_over);
global.topfit1 = ai_fitness_array[0];

// Normalize the fitnesses
var fit_tot = 0;
var fit_string = ""
for(var i=0; i<array_length; i++) {
    ai_fitness_array[i] = ai_fitness_array[i]/total_fit;
    fit_string = fit_string + string(ai_fitness_array[i]) + ", "
    fit_tot += ai_fitness_array[i];
}
//show_debug_message(fit_string);
//show_debug_message("This number should be 1.0: " + string(fit_tot));

//show_debug_message("Right before loop, pop_size is " + string(array_length));
// Mate the top half with random
for(var i=0; i<(array_length-num_to_carry_over); i++) {
    var r = random(1);
    //show_message("Looking for fitness better than " + string(r));
    var fit_sum = 0;
    for(var j=array_length-1; j>=0; j--) {
        fit_sum += ai_fitness_array[j];
        if((fit_sum >= r)) {
            //show_debug_message("Mating " + string(i) + " with " + string(j) + " with r of " + string(r));
            //show_debug_message("i+1 = " + string(i+1));
            temp_array[i+num_to_carry_over] = script_new_mating_helper(ai_array[i], ai_array[j]);
            //if(i+num_to_carry_over+array_length/2 < array_length) temp_array[i+array_length/2+num_to_carry_over] = script_new_mating_helper(ai_array[j], ai_array[i]);
            break;
        }
    }
}
//show_debug_message("Right after loop, pop_size is " + string(array_length_1d(temp_array)));

// If array length is odd, we'll have an empty space at the end. Copy the best performer to the next generation
//if(array_length%2 == 1) temp_array[array_length-1]= ai_array[0];

/* Shuffle the array so the best fighters don't always fight the best.
var l=ds_list_create()
for (var arr=0; arr<array_length_1d(temp_array); arr+=1) ds_list_add(l,temp_array[arr])
ds_list_shuffle(l)
for (var arr2=0; arr2<array_length_1d(temp_array); arr2+=1) temp_array[arr2]=ds_list_find_value(l,arr2)
ds_list_destroy(l)
*/

script_save_ai_generation(fighter, temp_array);

return temp_array;

