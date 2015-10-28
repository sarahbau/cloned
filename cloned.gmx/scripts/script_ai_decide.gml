var opponent=fighter.opponent;
var separation=abs(opponent.x-fighter.x);
separation = separation - (sprite_get_width(opponent.image_index)+sprite_get_xoffset(opponent.image_index))

player=-1;
if(fighter==fighter_obj[0]) player=1 else player=2;
//show_message("Player" + string(player) + " is [" + string(separation) + "] away from the enemy");


var my_kick_range = fighter.kick_range;
var my_punch_range = fighter.punch_range;
var my_range  = max(fighter.punch_range, fighter.kick_range);
var opp_range = max(opponent.punch_range, opponent.kick_range);
var opp_approaching=((opponent.hspeed+separation)<separation);

var p_punch   = prob_punch;
var p_kick    = prob_kick;
var p_forward = prob_forward;
var p_back    = prob_back;
var p_jump    = prob_jump;
var p_special = prob_special;
var p_block   = prob_block;


if(opp_range>separation) {
    if(opponent.attacking) {
        if(opp_range>=my_range) {
            p_block *= block_1;                    //block_1
            p_forward *= forward_1;                  //forward_1
        } else {
            p_back *= back_1;        //back_1
            p_forward *= forward_2;                  //forward_2
        }
    } else {
        if(opp_range>=my_range) {
            p_back *= back_2;                     //back_2
            p_forward *= forward_3;                  //forward_3
        }
    }
} else {
    p_back *= back_3;                             //back_3
    p_forward *= forward_4;                          //forward_4
}
if(my_range>separation) {
    if(my_kick_range>separation) {
        p_kick *= kick_1;                          //kick_1
    } else {
        p_kick *= kick_2;                            //kick_2
    }
    if(my_punch_range>separation) {
        p_punch *= punch_1;                         //punch_1
    } else {
        p_punch *= punch_2;                           //punch_2
    }
    p_forward *= forward_5;                          //forward_5
    p_back *= back_4;                             //back_4
} else {
    p_kick *= kick_3;                                //kick_3
    p_punch *= punch_3;                               //punch_3
}

var total=p_back+p_forward+p_punch+p_kick;
var r = random(total);
var i = 0;
var action = "none";
if(i<r) action="back";
i+=p_back;
if(i<r) action="forward";
i+=p_forward;
if(i<r) action="punch";
i+=p_punch;
if(i<r) action="kick";
i+=p_kick;

switch(action) {
    case "none":
        break;
    case "back":
//        show_message("Player" + string(player) + " wants to go back");
        if(fighter.facing_right) {
            script_move_left(fighter);
        } else {
            script_move_right(fighter);
        }
        break;
    case "forward":
//        show_message("Player" + string(player) + " wants to go forward");
        if(fighter.facing_right) {
            script_move_right(fighter);
        } else {
            script_move_left(fighter);
        }
        break;
    case "punch":
//        show_message("Player" + string(player) + " wants to punch");
        script_punch(fighter);
        break;
    case "kick":
//        show_message("Player" + string(player) + " wants to kick");
        script_kick(fighter);
        break;
}



