display_reset(0,false);
texture_set_interpolation(false);

global.training_speed = 10000;

with(controller_obj[0]) instance_change(obj_ai_controller, true);
with(controller_obj[1]) instance_change(obj_ai_controller, true);

globalvar p1_ai_array;
globalvar p2_ai_array;

for(i=99;i>=0;i--) {
    p1_ai_array[i] = ds_grid_create(8,32);   // New method
    p2_ai_array[i] = ds_grid_create(8,32);   // New method
}

global.ai_train_start = true;
global.training_mode=true;
script_referee_alarm0();

room_goto(rm_training);

