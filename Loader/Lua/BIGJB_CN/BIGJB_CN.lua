--这只是一个beta测试版本，一切功能造成的不稳定性，已尽量避免，由于开发并未提供有关菜单本身的api资讯，所以功能并不完善，或无法达成。

local function empty_fuction()
end
----------------------------------------------------------
local function empty_fuction()

end
--ui.toggle_button(" ", " ",  , empty_fuction, " ", " ")
----------------------------------------------------------
local function empty_fuction()
    
end
--ui.toggle_slider_button(" ", " ",  , empty_fuction, " ", " ")
----------------------------------------------------------
local function empty_fuction()

end
--ui.button(" ", " ", empty_fuction, " ", " ")
----------------------------------------------------------

ui.create_sub("~o~Project JB","lua_main_tab")
ui.create_sub("自我", "self_tab")
ui.create_sub("武器", "weap_tab")
ui.create_sub("载具", "veh_tab")
ui.create_sub("其他", "other_tab")
ui.create_sub("全局", "session_tab")
ui.create_sub("世界", "world_tab")
ui.create_sub("玩家", "player_tab")

------------------------------------------------------------------------------------------------------------------------------循环变量
local function flying()
    if PED.IS_PED_LANDING(util.get_local_ped()) == true then
        local flying = false
    end
end

local cages = {
    color_cages = {},
    small_cages = {},
    storage_cage = {},
    sechut_cage = {},
    elevator_cage = {}
}

local allWeapons         = {0x6589186A, 0x92A27487, 0x958A4A8F, 0xF9E6AA4B, 0x84BD7BFD, 0x8BB05FD7, 0x440E4788, 0x4E875F73, 0xF9DCBF2D, 0xD8DF3C3C, 0x99B507EA, 0xDD5DF8D9, 0xDFE37640, 0x678B81B1, 0x19044EE0, 0xCD274149, 0x94117305, 0x3813FC08, 0x1B06D571, 0xBFE256D4, 0x5EF9FEC4, 0x22D8FE39, 0x3656C8C1, 0x99AEEB3B, 0xBFD21232, 0x88374054, 0xD205520E, 0x83839C4 , 0x47757124, 0xDC4DB296, 0xC1B3C3D1, 0xCB96392F, 0x97EA20B8, 0xAF3696A1, 0x2B5EF5EC, 0x917F6C8C,0x1B06D571, 0xBFE256D4, 0x5EF9FEC4, 0x22D8FE39, 0x3656C8C1, 0x99AEEB3B, 0xBFD21232, 0x88374054, 0xD205520E, 0x83839C4 , 0x47757124, 0xDC4DB296, 0xC1B3C3D1, 0xCB96392F, 0x97EA20B8, 0xAF3696A1, 0x2B5EF5EC, 0x917F6C8C, 0x13532244, 0x2BE6766B, 0x78A97CD0, 0xEFE7E2DF, 0xA3D4D34, 0xDB1AA450, 0xBD248B55, 0x476BF155, 0x1D073A89, 0x555AF99A, 0x7846A318, 0xE284C527, 0x9D61E50F, 0xA89CB99E, 0x3AABBBAA, 0xEF951FBB, 0x12E82D3D, 0xBFEFFF6D, 0x394F415C, 0x83BF0278, 0xFAD1F1C9, 0xAF113F99, 0xC0A3098D, 0x969C3D67, 0x7F229F94, 0x84D6FAFD, 0x624FE830, 0x9D07F764, 0x7FD62962, 0xDBBD7280, 0x61012683, 0x5FC3C11, 0xC472FE2, 0xA914799, 0xC734385A, 0x6A6C02E0, 0xB1CA77B1, 0xA284510B, 0x4DD2DC56, 0x42BF8A85, 0x7F7497E5, 0x6D544C99, 0x63AB0442, 0x781FE4A, 0xB62D1F67, 0x93E220BD, 0xA0973D5E, 0xFDBC8A50, 0x497FACC3, 0x24B17070, 0x2C3731D9, 0xAB564B93, 0x787F0BB, 0xBA45E8B8, 0x23C9F95C, 0x60EC506, 0x787F0BB, 0x34A67B97, 0xFBAB5776, 0x88C78EB7}
local bodyguard_index    = 0
local spawned_bodyguards = {}
local filteredGuards     = {}
local guardBlips         = {}
local dismissedGuards    = false
local bodyguards = {
    {name = "Private Mercenaries",  pedType = "PED_TYPE_ARMY",                  modelHash = {a = 0x613E626C, b = 0x5076A73B, c = 0xB3F3EE34}, weaponHash = {main = 0x83BF0278, sec = 350597077},  vehicle = 2230595153,  vehCol = {prim = 153, sec = 12 },  vehRadio = "RADIO_19_USER"      },  -- Carbine Rifle + Tactical SMG
    {name = "High-Level Security",  pedType = "PED_TYPE_CIVMALE",               modelHash = {a = 0xF161D212, b = 0x2930C1AB, c = 0x55FE9B46}, weaponHash = {main = 0x2B5EF5EC, sec = 0},          vehicle = 666166960,   vehCol = {prim = 0,   sec = 0  },  vehRadio = "RADIO_19_USER"      },  -- Ceramic Pistol
    {name = "Ballas OGs",           pedType = "PED_TYPE_GANG_AFRICAN_AMERICAN", modelHash = {a = 0x231AF63F, b = 0xABEF0004, c = 0xDB41B4EF}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 3431608412,  vehCol = {prim = 145, sec = 145},  vehRadio = "RADIO_09_HIPHOP_OLD"},  -- Default Pistol
    {name = "Families OGs",         pedType = "PED_TYPE_GANG_AFRICAN_AMERICAN", modelHash = {a = 0x33A464E5, b = 0xE83B93B7, c = 0x84302B09}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 3265236814,  vehCol = {prim = 53,  sec = 53 },  vehRadio = "RADIO_03_HIPHOP_NEW"},  -- //
    {name = "Vagos Esses",          pedType = "PED_TYPE_GANG_PUERTO_RICAN",     modelHash = {a = 0x837B64DE, b = 0x5AA42C21, c = 0x964D12DC}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 2254540506,  vehCol = {prim = 88,  sec = 0  },  vehRadio = "RADIO_08_MEXICAN"   },  -- //
    {name = "Lost MC",              pedType = "PED_TYPE_GANG_BIKER_1",          modelHash = {a = 0x32B11CDC, b = 0x4F46D607, c = 0xFD5537DE}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 2549763894,  vehCol = {prim = 0,   sec = 0  },  vehRadio = "RADIO_04_PUNK"      },  -- //
    {name = "Armenian Mobsters",    pedType = "PED_TYPE_GANG_ALBANIAN",         modelHash = {a = 0xE7714013, b = 0xFDA94268, c = 0xF1E823A2}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 83136452,    vehCol = {prim = 111, sec = 0  },  vehRadio = "RADIO_15_MOTOWN"    },  -- //
    {name = "Cartel Sicarios",      pedType = "PED_TYPE_GANG_PUERTO_RICAN",     modelHash = {a = 0x995B3F9F, b = 0x7ED5AD78, c = 0xE6AC74A4}, weaponHash = {main = 0xBFEFFF6D, sec = 350597077},  vehicle = 4256087847,  vehCol = {prim = 0,   sec = 0  },  vehRadio = "RADIO_08_MEXICAN"   },  -- Assault Rifle + Tactical SMG
    {name = "Bad Bitches",          pedType = "PED_TYPE_PROSTITUTE",            modelHash = {a = 0x28ABF95,  b = 0x81441B71, c = 0xAEEA76B5}, weaponHash = {main = 350597077,  sec = 0},          vehicle = 461465043,   vehCol = {prim = 30,  sec = 111},  vehRadio = "RADIO_02_POP"       },  -- Tactical SMG
    {name = "Law: FIB",             pedType = "PED_TYPE_COP",                   modelHash = {a = 0xEDBC7546, b = 0x7B8B434B, c = 0x5CDEF405}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 2647026068,  vehCol = {prim = _,   sec = _  },  vehRadio = "OFF"                },
    {name = "Law: LSPD",            pedType = "PED_TYPE_COP",                   modelHash = {a = 0x5E3DA4A4, b = 0x15F8700D, c = 0x5E3DA4A4}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 1912215274,  vehCol = {prim = _,   sec = _  },  vehRadio = "OFF"                },
    {name = "Law: SWAT",            pedType = "PED_TYPE_COP",                   modelHash = {a = 0x8D8F1B10, b = 0x8D8F1B10, c = 0x8D8F1B10}, weaponHash = {main = 736523883,  sec = 0x1B06D571}, vehicle = 3089277354,  vehCol = {prim = _,   sec = _  },  vehRadio = "OFF"                },
}

local function updateGuards()
    filteredGuards = {}
    for _, bGuard in ipairs(bodyguards) do
        table.insert(filteredGuards, bGuard)
    end
    table.sort(filteredGuards, function(a, b)
        return a.name < b.name
    end)
end

local bGuardData  = filteredGuards[bodyguard_index + 1]
local myPos       = ENTITY.GET_ENTITY_COORDS(util.get_local_ped(), true)
local forwardX    = ENTITY.GET_ENTITY_FORWARD_X(util.get_local_ped())
local forwardY    = ENTITY.GET_ENTITY_FORWARD_Y(util.get_local_ped())
local myHeading   = ENTITY.GET_ENTITY_HEADING(util.get_local_ped())

local function bodyguard()
if spawned_bodyguards[1] == nil then

    local distMpl = 1.4
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(util.get_local_ped()) then
      distMpl = 7
    end
    local myGroup = PED.GET_PED_GROUP_INDEX(util.get_local_ped())
    if not PED.DOES_GROUP_EXIST(myGroup) then
      myGroup = PED.CREATE_GROUP(0)
    end
    PED.SET_PED_AS_GROUP_LEADER(util.get_local_ped(), myGroup)
    PED.SET_GROUP_SEPARATION_RANGE(myGroup, 16960)
    PED.SET_GROUP_FORMATION(myGroup, 2)
    PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
    while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.a) do
      STREAMING.REQUEST_MODEL(bGuardData.modelHash.a)
      util.yield()
    end

    guard_1 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.a, 0.0, 0.0, 0.0, 0.0, true, false)
    table.insert(spawned_bodyguards, guard_1)
    if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(guard_1) then
      ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_1, myPos.x + forwardX * distMpl, myPos.y + forwardY * distMpl, myPos.z, true, false, false)
      ENTITY.SET_ENTITY_HEADING(guard_1, myHeading - 180)
      ENTITY.SET_ENTITY_MAX_HEALTH(guard_1, 1000)
      ENTITY.SET_ENTITY_HEALTH(guard_1, 1000, 0, 0)
      PED.SET_PED_AS_GROUP_MEMBER(guard_1, myGroup)
      PED.SET_PED_NEVER_LEAVES_GROUP(guard_1, true)
      PED.SET_PED_ARMOUR(guard_1, 100)
      PED.SET_PED_SUFFERS_CRITICAL_HITS(guard_1, false)
      WEAPON.GIVE_WEAPON_TO_PED(guard_1, bGuardData.weaponHash.main, 9999, false, true)
      WEAPON.GIVE_WEAPON_TO_PED(guard_1, 0xFBAB5776, 1, false, false)
      WEAPON.SET_PED_INFINITE_AMMO(guard_1, true, bGuardData.weaponHash.main)
      if bGuardData.weaponHash.sec ~= 0 then
        WEAPON.GIVE_WEAPON_TO_PED(guard_1, bGuardData.weaponHash.sec, 9999, false, true)
        WEAPON.SET_PED_INFINITE_AMMO(guard_1, true, bGuardData.weaponHash.sec)
      end
      pedConfig(guard_1)
      guard_1Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_1)
      HUD.SET_BLIP_AS_FRIENDLY(guard_1Blip, true)
      HUD.SET_BLIP_SCALE(guard_1Blip, 0.8)
      HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_1Blip, true)
      --setBlipName("[私人保镖]", guard_1Blip)
      table.insert(guardBlips, guard_1Blip)
    end
    while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.b) do
      STREAMING.REQUEST_MODEL(bGuardData.modelHash.b)
      util.yield()
    end
    guard_2 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.b, 0.0, 0.0, 0.0, 0.0, true, false)
    table.insert(spawned_bodyguards, guard_2)
    if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(guard_2) then
      ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_2, myPos.x + forwardX * distMpl, myPos.y + forwardY * distMpl, myPos.z, true, false, false)
      ENTITY.SET_ENTITY_HEADING(guard_2, myHeading - 180)
      ENTITY.SET_ENTITY_MAX_HEALTH(guard_2, 1000)
      ENTITY.SET_ENTITY_HEALTH(guard_2, 1000, 0, 0)
      PED.SET_PED_AS_GROUP_MEMBER(guard_2, myGroup)
      PED.SET_PED_NEVER_LEAVES_GROUP(guard_2, true)
      PED.SET_PED_ARMOUR(guard_2, 100)
      PED.SET_PED_SUFFERS_CRITICAL_HITS(guard_2, false)
      WEAPON.GIVE_WEAPON_TO_PED(guard_2, bGuardData.weaponHash.main, 9999, false, true)
      WEAPON.GIVE_WEAPON_TO_PED(guard_2, 0xFBAB5776, 1, false, false)
      WEAPON.SET_PED_INFINITE_AMMO(guard_2, true, bGuardData.weaponHash.main)
      if bGuardData.weaponHash.sec ~= 0 then
        WEAPON.GIVE_WEAPON_TO_PED(guard_2, bGuardData.weaponHash.sec, 9999, false, true)
        WEAPON.SET_PED_INFINITE_AMMO(guard_2, true, bGuardData.weaponHash.sec)
      end
      pedConfig(guard_2)
      guard_2Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_2)
      HUD.SET_BLIP_AS_FRIENDLY(guard_2Blip, true)
      HUD.SET_BLIP_SCALE(guard_2Blip, 0.8)
      HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_2Blip, true)
      --setBlipName("[私人保镖]", guard_2Blip)
      table.insert(guardBlips, guard_2Blip)
    end
    while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.c) do
      STREAMING.REQUEST_MODEL(bGuardData.modelHash.c)
      util.yield()
    end
    guard_3 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.c, 0.0, 0.0, 0.0, 0.0, true, false)
    table.insert(spawned_bodyguards, guard_3)
    if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(guard_3) then
      ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_3, myPos.x + forwardX * distMpl, myPos.y + forwardY * distMpl, myPos.z, true, false, false)
      ENTITY.SET_ENTITY_HEADING(guard_3, myHeading - 180)
      ENTITY.SET_ENTITY_MAX_HEALTH(guard_3, 1000)
      ENTITY.SET_ENTITY_HEALTH(guard_3, 1000, 0, 0)
      PED.SET_PED_AS_GROUP_MEMBER(guard_3, myGroup)
      PED.SET_PED_NEVER_LEAVES_GROUP(guard_3, true)
      PED.SET_PED_ARMOUR(guard_3, 100)
      PED.SET_PED_SUFFERS_CRITICAL_HITS(guard_3, false)
      WEAPON.GIVE_WEAPON_TO_PED(guard_3, bGuardData.weaponHash.main, 9999, false, true)
      WEAPON.GIVE_WEAPON_TO_PED(guard_3, 0xFBAB5776, 1, false, false)
      WEAPON.SET_PED_INFINITE_AMMO(guard_3, true, bGuardData.weaponHash.main)
      if bGuardData.weaponHash.sec ~= 0 then
        WEAPON.GIVE_WEAPON_TO_PED(guard_3, bGuardData.weaponHash.sec, 9999, false, true)
        WEAPON.SET_PED_INFINITE_AMMO(guard_3, true, bGuardData.weaponHash.sec)
      end
      pedConfig(guard_3)
      guard_3Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_3)
      HUD.SET_BLIP_AS_FRIENDLY(guard_3Blip, true)
      HUD.SET_BLIP_SCALE(guard_3Blip, 0.8)
      HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_3Blip, true)
      --setBlipName("Bodyguard", guard_3Blip)
      table.insert(guardBlips, guard_3Blip)
    end
    dismissedGuards = false
    bg_unarmed      = false
    end
end
--ui.button("生成保镖", "生成你的专属保镖", bodyguard, "bodyguard_tab", "bodyguard")

local function dismissbodyguard()
if dismissedGuards then
    logger.log("[私人保镖]:你的私人保镖不存在或者已经解散了！")
    return
end
dismissedGuards = true
if ENTITY.DOES_ENTITY_EXIST(guard_1) then
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_1) then
      TASK.TASK_LEAVE_ANY_VEHICLE(guard_1, 100, 0)
    end
    TASK.TASK_WANDER_STANDARD(guard_1, 10.0, 10)
end
if ENTITY.DOES_ENTITY_EXIST(guard_2) then
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_2) then
      TASK.TASK_LEAVE_ANY_VEHICLE(guard_2, 100, 0)
    end
    TASK.TASK_WANDER_STANDARD(guard_2, 10.0, 10)
end
if ENTITY.DOES_ENTITY_EXIST(guard_3) then
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_3) then
      TASK.TASK_LEAVE_ANY_VEHICLE(guard_3, 100, 0)
    end
    TASK.TASK_WANDER_STANDARD(guard_3, 10.0, 10)
end

  logger.log("[私人保镖]:你的私人保镖已经解散了，请等待他们离开！")
  util.yield(10000)
  PED.DELETE_PED(guard_1)
  PED.DELETE_PED(guard_2)
  PED.DELETE_PED(guard_3)
  spawned_bodyguards = {}
  dismissedGuards = false

end
--ui.button("删除保镖", "删除你的保镖队伍。", dismissbodyguard, "bodyguard_tab", "dismissbodyguard")


lph520 = 0
crashing = 0
veh_trapping = 0
stopworldlp = 0
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

local function fake_Ban()
    HUD.SET_WARNING_MESSAGE_WITH_HEADER_AND_SUBSTRING_FLAGS("WARN", "JL_INVITE_ND", 2, "", true, -1, -1, "您已被永久禁止进入 Grand Theft Auto 在线模式。", "返回 Grand Theft Auto V。", true, 0)
end
ui.toggle_button("虚假封禁", "让你看起来被封禁了。", fake_Ban, empty_fuction, "self_tab", "fake_Ban")

local function play_sound()
    local player_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(util.get_local_ped(), 0, 0, 0)
    if 1==1 then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)
    end
end
--ui.button("play sd", "play", play_sound, "self_tab", "play_sound")

--ui.toggle_button("BigFireWing", "Give yourself a big firewing.", big_fire_wing_loop, big_fire_wing_off,"self_tab","big_fire_wing")
------------------------------------------------------------------------------------------------------------------------------武器选项
--ui.sub_button("武器选项", "与武器相关的功能。", empty_button,"lua_main_tab","weap_tab")

local function pedgun()

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)  

    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
        peds = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)    
        ENTITY.SET_ENTITY_ROTATION(peds, camrot.x, camrot.y, camrot.z, 1, false)    
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(peds, 1, 0, 1000, 0, false, true, true, true)
        ENTITY.SET_ENTITY_HEALTH(peds,1000,0,0)
    end

end
--ui.toggle_button("NPC枪", "让你射出NPC。", pedgun, empty_fuction, "weap_tab", "pedgun")

local function bsktgun()

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)

    objhash = util.joaat("prop_bskball_01")
    while not STREAMING.HAS_MODEL_LOADED(objhash) do		
        STREAMING.REQUEST_MODEL(objhash)
        util.yield()
    end

    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
        bskt = OBJECT.CREATE_OBJECT(objhash,pos.x, pos.y, pos.z, true, true, false)
        ENTITY.SET_ENTITY_ROTATION(bskt, camrot.x, camrot.y, camrot.z, 1, false)    
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(bskt, 1, 0, 1000, 0, false, true, true, true)
    end

end
--ui.toggle_button("篮球枪", "让你射出篮球。", bsktgun, empty_fuction, "weap_tab", "bsktgun")

local function bballgun()
    
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local camrot = CAM.GET_GAMEPLAY_CAM_ROT(0)

    objhash = util.joaat("v_ilev_exball_blue")
    while not STREAMING.HAS_MODEL_LOADED(objhash) do		
        STREAMING.REQUEST_MODEL(objhash)
        util.yield()
    end

    if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
        bskt = OBJECT.CREATE_OBJECT(objhash,pos.x, pos.y, pos.z, true, true, false)
        ENTITY.SET_ENTITY_ROTATION(bskt, camrot.x, camrot.y, camrot.z, 1, false)    
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(bskt, 1, 0, 1000, 0, false, true, true, true)
    end

end
--ui.toggle_button("大球枪", "让你射出大球。", bballgun, empty_fuction, "weap_tab", "bballgun")

------------------------------------------------------------------------------------------------------------------------------载具选项
--ui.sub_button("载具选项", "与载具相关的功能。(待完成)", empty_button,"lua_main_tab","veh_tab")

var.create_bool("was_in_vehicle",false)
local function ticker()
if util.get_local_vehicle() ~= 0 then
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
ui.add_loop(ticker)


------------------------------------------------------------------------------------------------------------------------------其他选项
--ui.sub_button("其他选项", "其他功能。(待完成)", empty_button,"lua_main_tab","other_tab")

--ui.create_sub("私人保镖", "bodyguard_tab")
--ui.sub_button("私人保镖", "生成你的专属保镖。", empty_button,"other_tab","bodyguard_tab")



------------------------------------------------------------------------------------------------------------------------------全局选项
ui.sub_button("全局选项", "应用在全局的功能。", empty_button,"lua_main_tab","session_tab")

ui.create_sub("全局崩溃", "crash_tab")
ui.sub_button("全局崩溃", "崩溃战局里的所有人。", empty_button,"session_tab","crash_tab")

local function ufo_crash() 
    if crashing == 0 then
        crashing = 1
        
        while not crashing == 0 do
            HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
            HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
            HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
            HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
        end

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
ui.sub_button("笼子", "生成各种笼子。", empty_button,"trolling_tab","cage_tab")

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

local function session_wanted()
    for i = 0,31 do
        PLAYER.SET_PLAYER_WANTED_LEVEL(PLAYER.GET_PLAYER_PED(i), 5, false)
    end
end
ui.toggle_button("全局通缉", "战局里的玩家将会被通缉。", session_wanted, empty_fuction,"trolling_tab","session_wanted")

local function veh_trapping()
    if veh_trapping == 0 then
        veh_trapping = 1
        for i = 0,31 do

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
    for i = 0,31 do

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

local function stop_orbroom()
    local objHash = util.joaat("prop_fnclink_03e")
    STREAMING.REQUEST_MODEL(objHash)
    while not STREAMING.HAS_MODEL_LOADED(objHash) do
        STREAMING.REQUEST_MODEL(objHash)
        logger.log(3)
        util.yield()
    end   

    local object = {}
    object[1] = OBJECT.CREATE_OBJECT(objHash, 335.8 - 1.5,4833.9 + 1.5, -60,true, true, false)
    object[2] = OBJECT.CREATE_OBJECT(objHash, 335.8 - 1.5,4833.9 - 1.5, -60,true, true, false)
    object[3] = OBJECT.CREATE_OBJECT(objHash, 335.8 + 1.5,4833.9 + 1.5, -60,true, true, false)
    local rot_3 = ENTITY.GET_ENTITY_ROTATION(object[3], 2)
    rot_3.z = -90.0
    ENTITY.SET_ENTITY_ROTATION(object[3], rot_3.x, rot_3.y, rot_3.z, 1, true)
    object[4] = OBJECT.CREATE_OBJECT(objHash, 335.8 - 1.5,4833.9 + 1.5, -60,true, true, false)
    local rot_4 = ENTITY.GET_ENTITY_ROTATION(object[4], 2)
    rot_4.z = -90.0

    ENTITY.SET_ENTITY_ROTATION(object[4], rot_4.x, rot_4.y,rot_4.z, 1, true)
    ENTITY.IS_ENTITY_STATIC(object[1]) 
    ENTITY.IS_ENTITY_STATIC(object[2])
    ENTITY.IS_ENTITY_STATIC(object[3])
    ENTITY.IS_ENTITY_STATIC(object[4])

    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(object[1], false) 
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(object[2], false) 
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(object[3], false) 
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(object[4], false) 

    for i = 1, 4 do ENTITY.FREEZE_ENTITY_POSITION(object[i], true) end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)

end
ui.button("禁用天基炮", "阻止所有人使用天基炮。", stop_orbroom, "trolling_tab", "stop_orbroom")

local function Air_Defences()

    for i = 0, 31 do
        aucoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(i), true)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", aucoords.x, aucoords.y, aucoords.z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
    end

end
ui.button("防空警报", "让战局里响起防空警报。", Air_Defences, "trolling_tab", "Air_Defences")

ui.create_sub("友善", "friendly_tab")
ui.sub_button("友善", "应用于全局的友善功能。", empty_button,"session_tab","friendly_tab")

local function session_no_wanted()
    for i = 0, 31 do
        if PLAYER.GET_PLAYER_WANTED_LEVEL(PLAYER.GET_PLAYER_PED(i)) ~= 0 then
            PLAYER.SET_PLAYER_WANTED_LEVEL(PLAYER.GET_PLAYER_PED(i), 0, false)
        end
    end
end
ui.toggle_button("全局无通缉", "战局里的玩家将不会被通缉。", session_no_wanted, empty_fuction,"friendly_tab","session_no_wanted")

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

local function world_stop_lp()
    if stopworldlp == 0 and HUD.GET_PAUSE_MENU_STATE() == 15 then

        logger.log("世界停止")
        MISC.SET_GAME_PAUSED(true)
        stopworldlp = 1

    end
end
local function world_stop_off()
    if stopworldlp == 1 and HUD.GET_PAUSE_MENU_STATE() == 0 then

        logger.log("世界恢复")
        MISC.SET_GAME_PAUSED(false)
        stopworldlp = 0

    end
end
--ui.toggle_button("线上本地暂停", "允许线上模式本地暂停。", world_stop_lp, world_stop_off, "world_tab","wd_sp")

------------------------------------------------------------------------------------------------------------------------------玩家选项
--ui.sub_button("玩家选项", "在线玩家功能。(待完成)", empty_button,"lua_main_tab","player_tab")

local function player_list()
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(i) then
            local player_name = PLAYER.GET_PLAYER_NAME(i)
        end
    end
end
--ui.button(player_name, "", player_list, "player_tab", "player_list")

































