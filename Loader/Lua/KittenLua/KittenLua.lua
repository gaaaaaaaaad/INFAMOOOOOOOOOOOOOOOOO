local function empty_fuction()
end

-- Creating main sub menu & name must be "lua_main_tab"
ui.create_sub("~o~Kitten Meaw","lua_main_tab") -- Create a sub-menu actual lua tab
---- Creating other sub menus
ui.create_sub("Player","player_tab") -- Create a sub-menu for player
ui.create_sub("Vehicle","vehicle_tab") -- Create a sub-menu for vehicles

-- Adding buttons to other sub-menus
ui.sub_button("Player", "Player options.", empty_button,"lua_main_tab","player_tab") -- Button in player sub-menu
ui.sub_button("Vehicle", "Vehicle options.", empty_button,"lua_main_tab","vehicle_tab") -- Button in vehicle sub-menu

var.create_bool("was_in_vehicle",false)
local function ticker()
-- this function will be called every frame
  if util.get_local_vehicle() ~= 0 then
  -- but we only want to do this if we are in a vehicle
  -- so we check if we are in a vehicle
  -- if we are in a vehicle, we check if we were in a vehicle last frame and does stuff
    if var.get_bool("was_in_vehicle") then
        local vehicle = util.get_local_vehicle()
	    local alpha = ENTITY.GET_ENTITY_ALPHA(vehicle) / 51
	    ui.set_int("vehicle_set_alpha", alpha)
        var.set_bool("was_in_vehicle",false)
	end
  else 
  	var.set_bool("was_in_vehicle",true)
   end 
end
--- adding a loop to the main loop
ui.add_loop(ticker)

local function local_ped_godmode_loop()
   ENTITY.SET_ENTITY_INVINCIBLE(util.get_local_ped(),true)
end
local function local_ped_godmode_off()
   ENTITY.SET_ENTITY_INVINCIBLE(util.get_local_ped(),false)
end
ui.toggle_button("God Mode", "Gets you god mode.", local_ped_godmode_loop,local_ped_godmode_off,"player_tab","self_god_mode") -- godmode


local function local_ped_super_run_loop()
    if TASK.IS_PED_SPRINTING(util.get_local_ped()) then
        ENTITY.APPLY_FORCE_TO_ENTITY(util.get_local_ped(), 1, 0, ui.get_int("self_super_run"), 0 , 0, 0, 0, 1, 1, 1, 1, 0, 1);
    end
end
ui.toggle_int_button("Super Run", "Running like wind.", local_ped_super_run_loop,empty_fuction,1,0,10,1,0,"player_tab","self_super_run") -- super run

local function local_ped_super_run_reverse_loop()
    if TASK.IS_PED_SPRINTING(util.get_local_ped()) then
	ENTITY.APPLY_FORCE_TO_ENTITY(util.get_local_ped(), 1, 0, - ui.get_float("self_reverse_run"), 0 , 0, 0, 0, 1, 1, 1, 1, 0, 1);
    end
end
ui.toggle_float_button("Reverse Super Run", "Running like wind to back.", local_ped_super_run_reverse_loop,empty_fuction,1,0,10,0.1,1,"player_tab","self_reverse_run") -- reverse running

local function local_ped_moon_walk_loop()
    if TASK.IS_PED_WALKING(util.get_local_ped()) then
	ENTITY.APPLY_FORCE_TO_ENTITY(util.get_local_ped(), 1, 0, - ui.get_float("self_moon_walk"), 0 , 0, 0, 0, 1, 1, 1, 1, 0, 1);
    end
end
ui.toggle_float_button("Moon Walking", "Moon walk like michael jackson.", local_ped_moon_walk_loop,empty_fuction,1,0,10,0.1,1,"player_tab","self_moon_walk") -- moon walking 

local function loca_ped_sprint_fast_lopp()
  PED.SET_PED_MOVE_RATE_OVERRIDE(util.get_local_ped(),ui.get_float("self_run_fast"))
end
ui.toggle_float_button("Fast Running", "Increase the speed of walking & running.", loca_ped_sprint_fast_lopp,empty_fuction,5,0,10,0.1,1,"player_tab","self_run_fast") -- moon walking 

local function local_self_go_crazy_loop()
   ENTITY.SET_ENTITY_INVINCIBLE(util.get_local_ped(),true)
   PED.SET_PED_RESET_FLAG(util.get_local_ped(), 81, true);
   ENTITY.APPLY_FORCE_TO_ENTITY(util.get_local_ped(), 1, util.get_random_float(-1,1),util.get_random_float(-1,1),util.get_random_float(-1,1) , 0, 0, 0, 1, 1, 1, 1, 0, 1);
end
local function local_self_go_crazy_off()
   ENTITY.SET_ENTITY_INVINCIBLE(util.get_local_ped(),false)
end
ui.toggle_button("Go Crazy Mode", "Makes you crazy  asf.", local_self_go_crazy_loop,local_self_go_crazy_off,"player_tab","self_go_crazy_mode") -- go crazy mode

-- what we are doing here is creating a int variable to store the object id. so it avoids creating multiple objects at the same time.
-- also entity variable is automatically deleted when the object is deleted. so no need to worry about deleting it.
function local_cone_spawning_loop()
    if var.get_entity("object_cone") == 0 then
        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(), 0, 10, 0)
        local hash = util.joaat("prop_roadcone02a")
        if util.request_model(hash) then
            local obj = OBJECT.CREATE_OBJECT(hash, player_coords.x, player_coords.y, player_coords.z, true, true, true)
            var.create_entity("object_cone", obj)
        end
    else 
        local obj = var.get_entity("object_cone")
        if not ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(obj, util.get_local_ped()) then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, util.get_local_ped(), PED.GET_PED_BONE_INDEX(util.get_local_ped(), 0x796E), 0.10, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0)
            ENTITY.SET_ENTITY_COLLISION(obj, false, false)
        end	
    end
end
local function local_cone_spawning_off()
 if ENTITY.DOES_ENTITY_EXIST(var.get_entity("object_cone")) then
    util.delete_entity(var.get_entity("object_cone"))
     end
end
ui.toggle_button("Cone On Head", "Spawns cone on head.", local_cone_spawning_loop,local_cone_spawning_off,"player_tab","cone_spawn_lol") -- cone on head

function local_umbrella_scene_loop()
			local dict = "anim@amb@nightclub@lazlow@hi_railing@"
			local anim = "ambclub_13_mi_hi_sexualgriding_laz"
			local walk_anim = "MOVE_P_M_ZERO_RUCKSACK"

    if var.get_entity("object_parasol") == 0 then
        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(), 0, 10, 0)
        local hash = util.joaat("prop_beach_parasol_09")
        if util.request_model(hash) then
            local obj = OBJECT.CREATE_OBJECT(hash, player_coords.x, player_coords.y, player_coords.z, true, true, true)
            var.create_entity("object_parasol", obj)
        end
    else 
        local obj = var.get_entity("object_parasol")
        if not ENTITY.IS_ENTITY_ATTACHED_TO_ENTITY(obj, util.get_local_ped()) then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, util.get_local_ped(), PED.GET_PED_BONE_INDEX(util.get_local_ped(), 0xDEAD), 0.1, -1, -0.2, -80, 0, 0, 0, 0, 0, 0, 0, 0)
            PED.SET_PED_WETNESS_HEIGHT(util.get_local_ped(),0)
			ENTITY.SET_ENTITY_COLLISION(obj, false, false)
			STREAMING.REQUEST_CLIP_SET(walk_anim);
			PED.SET_PED_WEAPON_MOVEMENT_CLIPSET(util.get_local_ped(), walk_anim);


        end	

    end
end
local function local_umbrella_scene_off()
 if ENTITY.DOES_ENTITY_EXIST(var.get_entity("object_parasol")) then
    util.delete_entity(var.get_entity("object_parasol"))
	PED.RESET_PED_WEAPON_MOVEMENT_CLIPSET(util.get_local_ped())
     end
end
ui.toggle_button("Umbrella ", "Spawns cone on head.", local_umbrella_scene_loop,local_umbrella_scene_off,"player_tab","cone_spawn_lol") -- cone on head

local function local_slow_mo_loop()
 MISC.SET_TIME_SCALE(ui.get_int("slomo_time_id") / 10)
end
local function local_slow_mo_off()
 MISC.SET_TIME_SCALE(1.0)
end
ui.toggle_int_slider_button("Slow-Mo Mode", "Slows down time.", local_slow_mo_loop,local_slow_mo_off,0,0,10,"player_tab","slomo_time_id")

--------------------------------------------------------------------------------------------- vehicle tab
local function input_spawn_vehicle()
   local text = util.get_keyboard_input("Input Vehicle Name")
   local hash = util.joaat(text)
    if util.request_model(hash) then
    local player_coords = util.get_front_of_cam(15)
    local vehicle = VEHICLE.CREATE_VEHICLE(hash, player_coords.x, player_coords.y, player_coords.z, ENTITY.GET_ENTITY_HEADING(util.get_local_ped()), true, true, true)
    PED.SET_PED_INTO_VEHICLE(util.get_local_ped(), vehicle, -1)
    end
end
ui.button("Input Spawn", "Spawn vehicle by name.", input_spawn_vehicle,"vehicle_tab","vehicle_spawn_input") -- Vehicle Spawn

local function local_veh_godmode_loop()
   ENTITY.SET_ENTITY_INVINCIBLE(util.get_local_vehicle(),true)
end
local function local_veh_godmode_off()
   ENTITY.SET_ENTITY_INVINCIBLE(util.get_local_vehicle(),false)
end
ui.toggle_button("God Mode", "Gets your vehicle godmode.", local_veh_godmode_loop,local_veh_godmode_off,"vehicle_tab","vehicle_god_mode") -- godmode vehicle

local function weird_vehicle_tank_mode()
    if not ENTITY.IS_ENTITY_UPSIDEDOWN(util.get_local_vehicle()) then
        VEHICLE.SET_VEHICLE_FIXED(util.get_local_vehicle())
    end
end
ui.toggle_button("Tank Mode", "Makes your vehicle stronger & tough.", weird_vehicle_tank_mode,empty_fuction,"vehicle_tab","vehicle_tank_mode") -- vehicle tank mode

local function horn_boost_vehicle()
    if AUDIO.IS_HORN_ACTIVE(util.get_local_vehicle()) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(util.get_local_vehicle(),ENTITY.GET_ENTITY_SPEED(util.get_local_vehicle()) + ui.get_int("vehicle_horn_boost"))
        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(),0,10,0)
    end
end
ui.toggle_int_button("Horn Boost", "Makes your vehicle fly when using horn.", horn_boost_vehicle,empty_fuction,1,1,100,1,0,"vehicle_tab","vehicle_horn_boost") -- vehicle horn boost

var.create_bool("vehicle_drift_check",true)
function local_vehicle_drift_tyres_loop()
    if (var.get_bool("vehicle_drift_check")) then
   var.create_bool("vehicle_drift_check2",VEHICLE.GET_DRIFT_TYRES_SET(util.get_local_vehicle()))
   var.set_bool("vehicle_drift_check",false)
   end

   if not VEHICLE.GET_DRIFT_TYRES_SET(util.get_local_vehicle()) then
   VEHICLE.SET_DRIFT_TYRES(util.get_local_vehicle(),true)
   end
end
local function local_vehicle_drift_tyres_off()
    --restore the original state
   VEHICLE.SET_DRIFT_TYRES(util.get_local_vehicle(),var.get_bool("vehicle_drift_check2"))
   var.remove("vehicle_drift_check2")
   var.set_bool("vehicle_drift_check", true)
end
ui.toggle_button("Drift Tyres", "Makes your vehicle tyres to drift ones.", local_vehicle_drift_tyres_loop,local_vehicle_drift_tyres_off,"vehicle_tab","vehicle_drift_tyres") -- drift tyres

local function local_vehicle_damage_loop()
	if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(util.get_local_vehicle()) then
	 MISC.SET_TIME_SCALE(0)
	 else
	  MISC.SET_TIME_SCALE(1)
	 end


  
end
local function local_vehicle_damage_off()
    --restore the original state
   VEHICLE.SET_DRIFT_TYRES(util.get_local_vehicle(),var.get_bool("vehicle_drift_check2"))
   var.remove("vehicle_drift_check2")
   var.set_bool("vehicle_drift_check", true)
end
ui.toggle_button("Collision Slow-Mo", "When ever you hit something with vehicle. Game will go into slomo mode.", local_vehicle_damage_loop,local_slow_mo_off,"vehicle_tab","vehicle_slmo") -- drift tyres


local function vehicle_boost()
   VEHICLE.SET_VEHICLE_FORWARD_SPEED(util.get_local_vehicle(),ui.get_int("vehicle_boost_forwards"))
 end
ui.int_button("Boost", "Boosts you're vehicle.", vehicle_boost,0,0,1000,10,0,false,"vehicle_tab","vehicle_boost_forwards")

local function vehicle_alpha()
   ENTITY. SET_ENTITY_ALPHA(util.get_local_vehicle(),ui.get_int("vehicle_set_alpha") * 51,true)
 end
ui.slider_button("Alpha", "Change alpha of your vehicle.", vehicle_alpha,5,0,5,true,"vehicle_tab","vehicle_set_alpha")


local function vehicle_infamous_color()
   VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(util.get_local_vehicle(),255,0,0)
   VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(util.get_local_vehicle(),255,0,0)
end
ui.button("Infamous ~r~Color", "Change your vehicle color to red.", vehicle_infamous_color,"vehicle_tab","vehicle_color_change_to_red") -- Vehicle color change to red

local function vehicle_fix()
   VEHICLE.SET_VEHICLE_FIXED(util.get_local_vehicle())
end

ui.button("Repair", "Fix your vehicle.", vehicle_fix,"vehicle_tab","vehicle_repair_vehicle") -- Vehicle repair

