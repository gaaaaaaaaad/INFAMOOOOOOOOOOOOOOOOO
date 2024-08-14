--这只是一个beta测试版本，一切功能造成的不稳定性，已尽量避免，由于开发并未提供有关菜单本身的api资讯，所以功能并不完善，或无法达成。

local function empty_fuction()
end

ui.create_sub("~o~Project JB","lua_main_tab")
ui.create_sub("自我", "self_tab")
ui.create_sub("全局", "session_tab")
ui.create_sub("世界", "world_tab")
ui.create_sub("玩家", "player_tab")

------------------------------------------------------------------------------------------------------------------------------循环变量
--local function fake_Ban()
--    HUD.SET_WARNING_MESSAGE_WITH_HEADER_AND_SUBSTRING_FLAGS("WARN","JL_INVITE_ND",2,"",true,-1,-1,"您已被永久禁止进入 Grand Theft Auto 在线模式。","返回 Grand Theft Auto V。",true,0)
--end
--ui.button("FakeBan Message", "Sending a fake BAN message.", fake_Ban,"self_tab","fake_ban_message")

local cages = {
    color_cages = {},
    small_cages = {},
    storage_cage = {},
    sechut_cage = {},
    elevator_cage = {}
}

lph520 = 0
crashing = 0
veh_trapping = 0

------------------------------------------------------------------------------------------------------------------------------自我选项
ui.sub_button("自我选项", "自我功能。", empty_button,"lua_main_tab","self_tab")

ui.create_sub("镜头", "cam_tab")
ui.sub_button("镜头", "调整镜头的设置。", empty_button, "self_tab", "cam_tab")

local function stop_cam_shake_loop()
    CAM.STOP_GAMEPLAY_CAM_SHAKING(true)
    CAM.SHAKE_GAMEPLAY_CAM("CLUB_DANCE_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("DAMPED_HAND_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("DEATH_FAIL_IN_EFFECT_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("DRONE_BOOST_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_BUMP_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_ENGINE_START_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_ENGINE_STOP_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_LOOP_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("HAND_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("HIGH_FALL_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("jolt_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("LARGE_EXPLOSION_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("MEDIUM_EXPLOSION_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("PLANE_PART_SPEED_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("ROAD_VIBRATION_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("SKY_DIVING_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("GRENADE_EXPLOSION_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("VIBRATE_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("SMALL_EXPLOSION_SHAKE", 0.0)
    CAM.SHAKE_GAMEPLAY_CAM("gameplay_explosion_shake", 0.0)
end
local function stop_cam_shake_off()
    CAM.STOP_GAMEPLAY_CAM_SHAKING(false)
    CAM.SHAKE_GAMEPLAY_CAM("CLUB_DANCE_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("DAMPED_HAND_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("DRONE_BOOST_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_BUMP_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_ENGINE_START_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_ENGINE_STOP_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("GUNRUNNING_LOOP_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("HAND_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("HIGH_FALL_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("jolt_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("LARGE_EXPLOSION_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("MEDIUM_EXPLOSION_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("PLANE_PART_SPEED_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("ROAD_VIBRATION_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("SKY_DIVING_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("GRENADE_EXPLOSION_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("VIBRATE_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("SMALL_EXPLOSION_SHAKE", 1.0)
    CAM.SHAKE_GAMEPLAY_CAM("gameplay_explosion_shake", 1.0)
end
ui.toggle_button("停止镜头晃动", "阻止让你镜头晃动的事件。", stop_cam_shake_loop, stop_cam_shake_off, "cam_tab", "stop_cam_shake_loop")

local function stop_idle_cam_loop()
    for i = 0,1 do
        CAM.INVALIDATE_IDLE_CAM()
        util.yield(29000)
    end
end
ui.toggle_button("停止空闲镜头", "停止让你在空闲后四处观望的功能。", stop_idle_cam_loop, empty_fuction, "cam_tab", "stop_cam_shake_loop")

local function local_ped_super_run_loop()
    if TASK.IS_PED_SPRINTING(util.get_local_ped()) then
        ENTITY.APPLY_FORCE_TO_ENTITY(util.get_local_ped(), 1, 0, ui.get_float("self_super_run"), 0 , 0, 0, 0, 1, 1, 1, 1, 0, 1);
    end
end
--ui.toggle_float_button("超级奔跑", "调节以控制向前或向后跑。", local_ped_super_run_loop, empty_fuction,0,-10,10,0.5,1,"self_tab","self_super_run")

local function head_520_loop()
    if lph520 == 0 then
        local num5 = "prop_mp_num_2"
        local num2 = "prop_mp_num_5"
        local num0 = "prop_mp_num_0"
        local user_ped = PLAYER.PLAYER_PED_ID()
        num5hash = util.joaat(num5)
        num2hash = util.joaat(num2)
        num0hash = util.joaat(num0)

        STREAMING.REQUEST_MODEL(num5hash)
        while not STREAMING.HAS_MODEL_LOADED(num5hash) do		
            util.yield()
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(num5hash)

        object5201 = OBJECT.CREATE_OBJECT(num5hash, 0.0,0.0,0, true, true, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(object5201, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0), 0.0, 0, 1.7, 0, 0, 0, false, false, false, false, 2, true, 1) 

        STREAMING.REQUEST_MODEL(num2hash)
        while not STREAMING.HAS_MODEL_LOADED(num2hash) do		
            util.yield()
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(num2hash)

        object5202 = OBJECT.CREATE_OBJECT(num2hash, 0.0,0.0,0, true, true, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(object5202, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0),  -1.0, 0, 1.7, 0, 0, 0, false, false, false, false, 2, true, 1) 

        STREAMING.REQUEST_MODEL(num0hash)
        while not STREAMING.HAS_MODEL_LOADED(num0hash) do		
            util.yield()
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(num0hash)

        object5203 = OBJECT.CREATE_OBJECT(num0hash, 0.0,0.0,0, true, true, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(object5203, user_ped, PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0),   1.0, 0, 1.7, 0, 0, 0, false, false, false, false, 2, true, 1)
    end
    lph520 = 1
end
local function head_520_off()
    if lph520 == 1 then
        util.delete_entity(object5201)
        util.delete_entity(object5202)
        util.delete_entity(object5203)
        lph520 = 0
    end
end
ui.toggle_button("头顶520", "让你的头顶生成520特效。", head_520_loop, head_520_off, "self_tab", "head_520")

local function play_sound()
    local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(), 0, 0, 0)
    if 1==1 then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)
    end
end
--ui.button("play sd", "play", play_sound, "self_tab", "play_sound")

--ui.toggle_button("BigFireWing", "Give yourself a big firewing.", big_fire_wing_loop, big_fire_wing_off,"self_tab","big_fire_wing")
------------------------------------------------------------------------------------------------------------------------------全局选项
ui.sub_button("全局选项", "应用在全局的功能。", empty_button,"lua_main_tab","session_tab")

ui.create_sub("全局崩溃", "crash_tab")
ui.sub_button("全局崩溃", "崩溃战局里的所有人。", empty_button,"session_tab","crash_tab")

local function ufo_crash() 
    if crashing == 0 then
        crashing = 1

        local hash = util.joaat("ruiner2")
        local player_origin_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(), 0, 0, 0)
    
        if util.request_model(hash) then
        local vehicle = VEHICLE.CREATE_VEHICLE(hash, 0, 0, 500, ENTITY.GET_ENTITY_HEADING(util.get_local_ped()), true, true, true)
        NETWORK.SET_NETWORK_VEHICLE_AS_GHOST(vehicle, true)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(vehicle, util.joaat("sum_prop_dufocore_01a"))
        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -50.0)
        PED.SET_PED_INTO_VEHICLE(util.get_local_ped(), vehicle, -1)
        
        ENTITY.SET_ENTITY_ALPHA(util.get_local_ped(), 0, false)
        ENTITY.SET_ENTITY_ALPHA(vehicle, 0, false)
        util.yield()

        VEHICLE.VEHICLE_START_PARACHUTING(vehicle, true)
        util.yield(2000)
        util.delete_entity(vehicle)
        end
        ENTITY.SET_ENTITY_ALPHA(util.get_local_ped(), 255, false)
        PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), player_origin_coords.x, player_origin_coords.y, player_origin_coords.z)

    end
    util.yield(200)
    crashing = 0
end
ui.button("UFO崩溃", "外星人会带走他们。", ufo_crash, "crash_tab", "ufo_crash")

local function falling_crash() 
    if crashing == 0 then
        crashing = 1

        local player_origin_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(), 0, 0, 0)
        local ppos = ENTITY.GET_ENTITY_COORDS(util.get_local_ped(), true)
    
        for n = 0 , 5 do
            local object_hash = util.joaat("prop_logpile_06b")
            STREAMING.REQUEST_MODEL(object_hash)
            while not STREAMING.HAS_MODEL_LOADED(object_hash) do
                util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(util.get_local_ped(), 0,0,500, false, true, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(util.get_local_ped(), 0xFBAB5776, 1000, false)
            util.yield(1000)
    
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(util.get_local_ped())
            end
            util.yield(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(util.get_local_ped(), ppos.x, ppos.y, ppos.z, false, true, true)
    
            local object_hash2 = util.joaat("prop_beach_parasol_03")
            STREAMING.REQUEST_MODEL(object_hash2)
            while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
                util.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(util.get_local_ped(), 0,0,500, false, false, true)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(util.get_local_ped(), 0xFBAB5776, 1000, false)
            util.yield(1000)
            
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(util.get_local_ped())
            end
            util.yield(1000)

        end
        PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), player_origin_coords.x, player_origin_coords.y, player_origin_coords.z)
        PLAYER.CLEAR_PLAYER_PARACHUTE_MODEL_OVERRIDE(util.get_local_ped())
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(util.get_local_ped())    
    end
    util.yield(25000)
    crashing = 0
end
ui.button("坠落崩", "把他们都砸死。", falling_crash, "crash_tab", "falling_crash")

local function sound_crash_loop()
    if crashing == 0 then
        crashing = 1

        for i = 0, 63 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Event_Message_Purple", util.get_local_ped(), "GTAO_FM_Events_Soundset", true, 0)
        end
        util.yield(100)
        for i = 0, 31 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Event_Message_Purple", PLAYER.GET_PLAYER_PED(i), "GTAO_FM_Events_Soundset", true, 0)
        end
        util.yield(100)

    end
    util.yield(200)
    crashing = 0
end
ui.toggle_button("脚本声音崩溃", "非常好的声音，使他们游戏崩溃。", sound_crash_loop, empty_fuction, "crash_tab", "sound_carsh")


ui.create_sub("笼子", "cage_tab")
ui.sub_button("笼子", "生成各种笼子。", empty_button,"session_tab","cage_tab")

local function tube_cage()
    for i = -1,31 do

        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
        local obj = OBJECT.CREATE_OBJECT_NO_OFFSET(685123030, player_coords.x, player_coords.y, player_coords.z, true, true, false)
        local obj2 = OBJECT.CREATE_OBJECT_NO_OFFSET(685123030, player_coords.x, player_coords.y, player_coords.z, true, true, false)
        local color_cage = ENTITY.SET_ENTITY_ROTATION(obj, 0 ,45 ,0, 0, false)
        local color_cage2 = ENTITY.SET_ENTITY_ROTATION(obj2, 0 ,-45 ,0, 0, false)
        table.insert(cages.color_cages, obj)
        table.insert(cages.color_cages, obj2)

    end
end
ui.button("炫彩笼子", "生成让你眼前一亮的笼子。", tube_cage, "cage_tab", "tube_cage")

local function sechut_cage()
    for i = -1,31 do

        local objHash = util.joaat("prop_air_sechut_01")

        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
        local obj = OBJECT.CREATE_OBJECT(objHash, player_coords.x, player_coords.y, player_coords.z-1, true, true, false)
        local obj2 = OBJECT.CREATE_OBJECT(objHash, player_coords.x, player_coords.y, player_coords.z-1, true, true, false)
        local sechut_cage = ENTITY.SET_ENTITY_ROTATION(obj2, 0 ,0 ,180, 0, false)
        util.yield(200)
        local ped = PED.CREATE_PED( 0, pedHash, player_coords.x, player_coords.y, player_coords.z, 0, true, false)
        table.insert(cages.sechut_cage, obj)
        table.insert(cages.sechut_cage, obj2)

    end
end
ui.button("保安室笼子", "让玩家成为保安。", sechut_cage, "cage_tab", "sechut_cage")

local function elevator_cage()
    for i = -1,31 do

        local objHash = util.joaat("xm_prop_iaa_base_elevator")
        STREAMING.REQUEST_MODEL(objHash)

        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
        local obj = OBJECT.CREATE_OBJECT(objHash, player_coords.x, player_coords.y, player_coords.z-1, true, true, false)
        local obj2 = OBJECT.CREATE_OBJECT(objHash, player_coords.x, player_coords.y, player_coords.z-1, true, true, false)
        local elevator_cage = ENTITY.SET_ENTITY_ROTATION(obj2, 0 ,0 ,180, 0, false)
        table.insert(cages.elevator_cage, obj)
        table.insert(cages.elevator_cage, obj2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)

    end
end
ui.button("电梯笼子", "生成电梯困住玩家。", elevator_cage, "cage_tab", "elevator_cage")

local function storage_cage()
    for i = -1,31 do

        local objHash = util.joaat("prop_container_ld_pu")
        STREAMING.REQUEST_MODEL(objHash)
        
        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
        local obj = OBJECT.CREATE_OBJECT(objHash, player_coords.x, player_coords.y, player_coords.z-1, true, true, false)
        table.insert(cages.storage_cage, obj)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)  

    end
end
ui.button("货柜笼子", "生成货柜笼罩玩家。", storage_cage, "cage_tab", "storage_cage")

local function small_cage()
    for i = -1,31 do

        local objHash = util.joaat("prop_gold_cont_01")
        STREAMING.REQUEST_MODEL(objHash)
        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
        local obj = OBJECT.CREATE_OBJECT(objHash, player_coords.x, player_coords.y, player_coords.z-1, true, true, false)
        table.insert(cages.small_cages, obj)
        ENTITY.FREEZE_ENTITY_POSITION(obj, true)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)
        
    end
end
ui.button("小笼子", "生成一个小笼子。", small_cage, "cage_tab", "small_cage")

local function delete_all_cage()

    for _, cage in ipairs(cages.color_cages) do
        util.delete_entity(cage)
    end
    cages.color_cages = {}

    for _, cage in ipairs(cages.small_cages) do
        util.delete_entity(cage)
    end
    cages.small_cages = {}

    for _, cage in ipairs(cages.storage_cage) do
        util.delete_entity(cage)
    end
    cages.storage_cage = {}

    for _, cage in ipairs(cages.sechut_cage) do
        util.delete_entity(cage)
    end
    cages.sechut_cage = {}

    for _, cage in ipairs(cages.elevator_cage) do
        util.delete_entity(cage)
    end
    cages.elevator_cage = {}

end
ui.button("清除笼子", "清除你生成的所有笼子。", delete_all_cage, "cage_tab", "delete_all_cage")

ui.create_sub("恶搞", "trolling_tab")
ui.sub_button("恶搞", "恶搞战局里的玩家。", empty_button,"session_tab","trolling_tab")

local function veh_trapping()
    if veh_trapping == 0 then
        veh_trapping = 1
        for i = -1,31 do

            local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
            local modelHash = util.joaat("Yosemite")

            STREAMING.REQUEST_MODEL(modelHash)
            while not STREAMING.HAS_MODEL_LOADED(modelHash) do
                STREAMING.REQUEST_MODEL(modelHash)
                util.yield()
            end

            local vehicle = VEHICLE.CREATE_VEHICLE(modelHash, player_coords.x, player_coords.y, player_coords.z + 20, 0.0, true, false)
            ENTITY.SET_ENTITY_ROTATION(vehicle, 0, 0, 0, 2, true)
            local networkId = NETWORK.VEH_TO_NET(vehicle)

            if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle) then
                NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
            end

            if vehicle then
                ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -1000000)
            end

            local vehicle2 = VEHICLE.CREATE_VEHICLE(modelHash, player_coords.x, player_coords.y, player_coords.z - 20, 0.0, true, false)
            ENTITY.SET_ENTITY_ROTATION(vehicle2, 0, 0, 0, 2, true)
            local networkId = NETWORK.VEH_TO_NET(vehicle2)

            if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle2) then
                NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
            end
    
            if vehicle2 then
                ENTITY.SET_ENTITY_VELOCITY(vehicle2, 0, 0, 1000000)
            end
    
            util.yield(200)
            util.delete_entity(vehicle)
            util.delete_entity(vehicle2)    
        end
    end
    util.yield()
    veh_trapping = 0
end
ui.button("载具夹层", "载具会夹住他们。", veh_trapping, "trolling_tab", "veh_trapping")

local function veh_crush_loop()
    for i = -1,31 do

        local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(i), 0, 0, 0)
        local modelHash = util.joaat("Yosemite")

        STREAMING.REQUEST_MODEL(modelHash)
        while not STREAMING.HAS_MODEL_LOADED(modelHash) do
            STREAMING.REQUEST_MODEL(modelHash)
            util.yield()
        end

        local vehicle = VEHICLE.CREATE_VEHICLE(modelHash, player_coords.x, player_coords.y, player_coords.z + 20, 0.0, true, false)
        ENTITY.SET_ENTITY_ROTATION(vehicle, 0, 0, 0, 2, true)
        local networkId = NETWORK.VEH_TO_NET(vehicle)

        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(vehicle) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(networkId, true)
        end

        if vehicle then
            ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, -1000000)
        end
        util.yield(200)
    end
end
local function veh_crush_off()
    util.delete_entity(vehicle)
end
--ui.toggle_button("载具碾压", "载具会碾压他们。", veh_crush_loop, veh_crush_off, "trolling_tab", "veh_crush")

--local function lock_all_door()
    --VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS("", true)
--ui.button("锁定载具门", "锁定全局玩家的载具门。", lock_all_door, "session_tab", "lock_all_door")
------------------------------------------------------------------------------------------------------------------------------世界选项
ui.sub_button("世界选项", "应用在世界的功能。", empty_button,"lua_main_tab","world_tab")

local function lock_time_loop()
    if ui.get_int("lock_time") == 0 then
        CLOCK.SET_CLOCK_TIME(13, 00, 00)
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(13, 00, 00)
    end
    if ui.get_int("lock_time") == 1 then
        CLOCK.SET_CLOCK_TIME(01, 00, 00)
        NETWORK.NETWORK_OVERRIDE_CLOCK_TIME(1, 00, 00)
    end
end
local function lock_time_off()
    NETWORK.NETWORK_CLEAR_CLOCK_TIME_OVERRIDE()
end
ui.toggle_int_slider_button("锁定时间", "0是早上 1是晚上。", lock_time_loop, lock_time_off, 0, 1, 0, "world_tab","lock_time")

------------------------------------------------------------------------------------------------------------------------------玩家选项
ui.sub_button("玩家选项", "在线玩家功能。", empty_button,"lua_main_tab","player_tab")

local function player_list()
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(i) then
            local player_name = PLAYER.GET_PLAYER_NAME(i)
        end
    end
end
--ui.button(player_name, "", player_list, "player_tab", "player_list")

































