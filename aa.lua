local client_userid_to_entindex, entity_get_local_player, ui_get, ui_reference, client_draw_indicator, client_set_event_callback, ui_set, globals_curtime, client_delay_call, math_random, ui_new_checkbox, ui_new_slider, ui_set_callback = client.userid_to_entindex, entity.get_local_player, ui.get, ui.reference, client.draw_indicator, client.set_event_callback, ui.set, globals.curtime, client.delay_call, math.random, ui.new_checkbox, ui.new_slider, ui.set_callback
local a_b = ui_new_checkbox("AA", "Anti-aimbot angles", "KRIPSI AA")
local visuals = {
    
    ind_select = ui.new_combobox("AA", "Anti-aimbot angles", "Select Indicator Style", {"First", "Second"}),
    ind_label = ui.new_label("AA", "Anti-aimbot angles", "Active side color"),
    ind_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Indicator Color", 255, 255, 255, 255),
    rect_label = ui.new_label("AA", "Anti-aimbot angles", "Rectangle color"),
    rect_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "Rectangle color", 255, 255, 255, 255),
    cross_label = ui.new_label("AA", "Anti-aimbot angles", "State indicator color"),
    cross_clr = ui.new_color_picker("AA", "Anti-aimbot angles", "State indicator color", 255, 255, 255, 255),
    fade1_label = ui.new_label("AA", "Anti-aimbot angles", "First Gradient Color"),
    first_gradient = ui.new_color_picker("AA", "Anti-aimbot angles", "First Gradient Color", 255, 0, 127, 0),
    fade2_label = ui.new_label("AA", "Anti-aimbot angles", "Second Gradient Color"),
    second_gradient = ui.new_color_picker("AA", "Anti-aimbot angles", "Second Gradient Color", 255, 0, 127, 255),

}
local KRIPSI_ROLL = ui_new_checkbox("AA", "Anti-aimbot angles", "KRIPSI ROLL")
local sexy = ui.new_multiselect("AA","Anti-aimbot angles","Roll State On:","In Air","On Ladders","Low Stamina","On Key","< Speed Velocity")
local body_yaw, body_yaw_s = ui_reference("AA", "Anti-aimbot angles", "Body Yaw")
local yaw, yaw_s = ui_reference("AA", "Anti-aimbot angles", "Yaw")
local pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
local fakeyawlimit = ui_reference("aa", "anti-aimbot angles", "Fake yaw limit")
local yawbody, yaw = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local bodyyaw, bodyyaw2 = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local freeyaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
local jyaw, jyawslide = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local freestanding, freestanding2 = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local fyawlimit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local freestand_byaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local slow_walk, slow_walk2 = ui.reference("AA", "Other", "Slow motion")
local key3 = ui.new_hotkey("AA", "Anti-aimbot angles", "Force Rolling Angle on Key (Speed Decrease)")
local checkbox_hitchecker = ui.new_checkbox("AA", "Anti-aimbot angles", "Disable Roll when impacted", true)
local velocity_slider = ui.new_slider("AA", "Anti-aimbot angles", "Roll Velocity Trigger", 40, 250, 120, true, " ")
local stamina_slider = ui.new_slider("AA", "Anti-aimbot angles", "Stamina Recovery", 0, 80, 70, true, " ")
local in_air_roll = ui.new_slider("AA","Anti-aimbot angles","Customized Roll in air",  -50, 50, 50, true, " ")
local slider_roll = ui.new_slider("AA", "Anti-aimbot angles", "Roll", -50, 50, 50, true, "°")

local ab_p = 1 --antibrute_phase
local ab_p_r = 1
local lastsent_p = globals.tickcount()






local bit_band, client_camera_angles, client_color_log, client_create_interface, client_delay_call, client_exec, client_eye_position, client_key_state, client_log, client_random_int, client_scale_damage, client_screen_size, client_set_event_callback, client_trace_bullet, client_userid_to_entindex, database_read, database_write, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, entity_is_alive, entity_is_enemy, math_abs, math_atan2, require, error, globals_absoluteframetime, globals_curtime, globals_realtime, math_atan, math_cos, math_deg, math_floor, math_max, math_min, math_rad, math_sin, math_sqrt, print, renderer_circle_outline, renderer_gradient, renderer_measure_text, renderer_rectangle, renderer_text, renderer_triangle, string_find, string_gmatch, string_gsub, string_lower, table_insert, table_remove, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_hotkey, ui_new_multiselect, ui_reference, tostring, ui_is_menu_open, ui_mouse_position, ui_new_combobox, ui_new_slider, ui_set, ui_set_callback, ui_set_visible, tonumber, pcall = bit.band, client.camera_angles, client.color_log, client.create_interface, client.delay_call, client.exec, client.eye_position, client.key_state, client.log, client.random_int, client.scale_damage, client.screen_size, client.set_event_callback, client.trace_bullet, client.userid_to_entindex, database.read, database.write, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, entity.is_alive, entity.is_enemy, math.abs, math.atan2, require, error, globals.absoluteframetime, globals.curtime, globals.realtime, math.atan, math.cos, math.deg, math.floor, math.max, math.min, math.rad, math.sin, math.sqrt, print, renderer.circle_outline, renderer.gradient, renderer.measure_text, renderer.rectangle, renderer.text, renderer.triangle, string.find, string.gmatch, string.gsub, string.lower, table.insert, table.remove, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_hotkey, ui.new_multiselect, ui.reference, tostring, ui.is_menu_open, ui.mouse_position, ui.new_combobox, ui.new_slider, ui.set, ui.set_callback, ui.set_visible, tonumber, pcall
local ui_menu_position, ui_menu_size, math_pi, renderer_indicator, entity_is_dormant, client_set_clan_tag, client_trace_line, entity_get_all, entity_get_classname = ui.menu_position, ui.menu_size, math.pi, renderer.indicator, entity.is_dormant, client.set_clan_tag, client.trace_line, entity.get_all, entity.get_classname
local local_player = entity.get_local_player()
local plist_set = plist.get
local vector = require('vector')
local images = require 'gamesense/surface'

local ffi = require('ffi')
local ffi_cast = ffi.cast

local js = panorama.open()
local persona_api = js.MyPersonaAPI
local name = persona_api.GetName()

client.color_log(255, 255, 255, "|--------------------------------------------------------|")
client.color_log(21, 235, 220,  "                         KRIPSI AA (V2) INJECTED       ")
client.color_log(215, 115, 222, "              (︶︹︺) Coded by KRIPSI#5061 (︶︹︺)               ")
client.color_log(235, 221, 21,  "                    Last Updated: 08/05/2022.               ")
client.color_log(255, 255, 255, "|--------------------------------------------------------|")














local function run_command()
	
        
        
        
    if ui.get(KRIPSI_ROLL) then
            ui.set_visible(yawbody, false)
            ui.set_visible(yaw, false)
            ui.set_visible(bodyyaw, false)
            ui.set_visible(bodyyaw2, false)
            ui.set_visible(edge, false)
            ui.set_visible(jyaw, false)
            ui.set_visible(jyawslide, false)
            ui.set_visible(pitch, false)
            ui.set_visible(yawbase, false)
            ui.set_visible(freestanding, false)
            ui.set_visible(freestanding2, false)
            ui.set_visible(fyawlimit, false)
            ui.set_visible(freestand_byaw, false)
            ui.set_visible(a_b, true) 
            ui.set_visible(sexy, true) 
           
    end  

    if not ui.get(KRIPSI_ROLL) then 
        ui.set_visible(yawbody, false)
        ui.set_visible(yaw, false)
        ui.set_visible(bodyyaw, false)
        ui.set_visible(bodyyaw2, false)
        ui.set_visible(edge, false)
        ui.set_visible(jyaw, false)
        ui.set_visible(jyawslide, false)
        ui.set_visible(pitch, false)
        ui.set_visible(yawbase, false)
        ui.set_visible(freestanding, false)
        ui.set_visible(freestanding2, false)
        ui.set_visible(fyawlimit, false)
        ui.set_visible(freestand_byaw, false)
        ui.set_visible(a_b, true) 
        ui.set_visible(sexy, false) 
        ui.set_visible(key3, false) 
        ui.set_visible(checkbox_hitchecker, false) 
        ui.set_visible(in_air_roll, false) 
        ui.set_visible(velocity_slider, false) 
        ui.set_visible(stamina_slider, false) 
        ui.set_visible(slider_roll, false)
end
        
    
end










--aa
local function on_player_hurt(e)
	
	local userid, attacker, health, armor, weapon, dmg_health, dmg_armor, hitgroup = e.userid, e.attacker, e.health, e.armor, e.weapon, e.dmg_health, e.dmg_armor, e.hitgroup
	if client_userid_to_entindex(userid) == entity_get_local_player() and hitgroup ~= 0 then
		if (ui_get(a_b)) then
			ab_p = ab_p + 1
			ab_p_r = ab_p_r + 1
			if ab_p > 4 then
				ab_p = 1
			end
			if ab_p == 1 or ab_p == 3 then
				ui.set(bodyyaw, "Jitter")
				local old = ui_get(yaw_s)
				ui.set(pitch, "Default")
				ui.set(yawbase, "At targets")
				ui.set(yaw, -10)
				ui.set(yawbody, "180")
				ui.set(jyaw, "Center")
				ui.set(jyawslide, 58)
				ui.set(bodyyaw2, 0)
				ui.set(freestand_byaw, false)
				ui.set(fyawlimit, 60)
			elseif ab_p == 2 then
				ui.set(pitch, "Default")
                ui.set(yawbase, "At targets")
                ui.set(yaw, 5)
                ui.set(yawbody, "180")
                ui.set(jyaw, "Center")
                ui.set(jyawslide, 0)
                ui.set(bodyyaw, "Jitter")
                ui.set(bodyyaw2, -79)
                ui.set(freestand_byaw, false)
                ui.set(fyawlimit, math.random(30,45))
			elseif ab_p == 4 then
		        ui.set(pitch, "Default")
                ui.set(yawbase, "At targets")
                ui.set(yaw, 0)
                ui.set(yawbody, "180")
                ui.set(jyaw, "Center")
                ui.set(jyawslide, 25)
                ui.set(bodyyaw, "Jitter")
                ui.set(bodyyaw2, 0)
                ui.set(freestand_byaw, true)
                ui.set(fyawlimit, 60)
			end
		end
		
	end

end

local function on_paint(ctx)
	if (ui_get(a_b)) then
		client.draw_indicator(c, 124, 252, 252, 252, "KRIPSI AA") 
	end
	
end

local function prestart()
	if (ui_get(a_b)) then
		ui_set(body_yaw, "Jitter")
		ab_p = 1
		ab_p_r = 1
		ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 3)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 60)
		ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 58)
	end
	
end





----roll aa

local bit_band = bit.band
local entity_get_local_player, entity_is_alive, entity_get_prop, entity_get_player_weapon =
    entity.get_local_player,
    entity.is_alive,
    entity.get_prop,
    entity.get_player_weapon

-- Libraries
local ffi = require "ffi"
local vector = require("vector")
local ui_set = ui.set
local globals_tickcount, globals_realtime = globals.tickcount, globals.realtime
local entity_get_local_player, entity_is_alive, entity_get_prop, entity_get_player_weapon =
    entity.get_local_player,
    entity.is_alive,
    entity.get_prop,
    entity.get_player_weapon
local math_cos, math_sin, math_rad, math_sqrt = math.cos, math.sin, math.rad, math.sqrt
local function contains(tbl, val)
    for i = 1, #tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end
ui_reference = ui.reference
local angle_t = ffi.typeof("struct { float pitch; float yaw; float roll; }")
local vector3_t = ffi.typeof("struct { float x; float y; float z; }")

local usercmd_t =
    ffi.typeof(
    [[
    struct
    {
        uintptr_t vfptr;
        int command_number;
        int tick_count;
        $ viewangles;
        $ aimdirection;
        float forwardmove;
        float sidemove;
        float upmove;
        int buttons;
        uint8_t impulse;
        int weaponselect;
        int weaponsubtype;
        int random_seed;
        short mousedx;
        short mousedy;
        bool hasbeenpredicted;
        $ headangles;
        $ headoffset;
    }
    ]],
    angle_t,
    vector3_t,
    angle_t,
    vector3_t
)

local get_user_cmd_t = ffi.typeof("$* (__thiscall*)(uintptr_t ecx, int nSlot, int sequence_number)", usercmd_t)

local input_vtbl_t =
    ffi.typeof(
    [[
    struct
    {
        uintptr_t padding[8];
        $ GetUserCmd;
    }
    ]],
    get_user_cmd_t
)

local input_t = ffi.typeof([[
    struct
    {
        $* vfptr;
    }*
    ]], input_vtbl_t)

-- ugly casting LMAO
local g_pInput =
    ffi.cast(
    input_t,
    ffi.cast(
        "uintptr_t**",
        tonumber(
            ffi.cast(
                "uintptr_t",
                client.find_signature("client.dll", "\xB9\xCC\xCC\xCC\xCC\x8B\x40\x38\xFF\xD0\x84\xC0\x0F\x85") or
                    error("client.dll!:input not found.")
            )
        ) + 1
    )[0]
)

local lua_log = function(...) --inspired by sapphyrus' multicolorlog
    client.color_log(255, 59, 59, "[ KRIPSI AA ]\0")
    local arg_index = 1
    while select(arg_index, ...) ~= nil do
        client.color_log(217, 217, 217, " ", select(arg_index, ...), "\0")
        arg_index = arg_index + 1
    end
    client.color_log(217, 217, 217, " ") -- this is needed to end the line
end

lua_log("Set Velocity Triggers to 80 if you are using Auto/AWP")

local references = {
    fake_yaw_limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")},
    body_yaw = {ui.reference("AA", "Anti-aimbot angles", "Body yaw")},
    yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
    jitter = {ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")},
    fake_limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    roll = {ui.reference("AA", "Anti-aimbot angles" , "Roll")},
}

local function setup()
    ui.set(references.yaw[1], "180")
    ui.set(references.body_yaw[2], 137)
    ui.set(references.yaw_base, "At targets")
    ui.set(references.body_yaw[1], "Static")
    ui.set(references.pitch, "Minimal")
    ui.set(references.jitter[2], 0)
    ui.set(references.fake_limit, 60)
end
setup()
local function on_setup_command(cmd)
    g_pOldAngles = vector(cmd.pitch, cmd.yaw, cmd.roll)
end






local function velocity()
    local me = entity_get_local_player()
    local velocity_x, velocity_y = entity_get_prop(me, "m_vecVelocity")
    return math.sqrt(velocity_x ^ 2 + velocity_y ^ 2)
end
ui.set_visible(key3, false)
ui.set_visible(velocity_slider, false)
ui.set_visible(stamina_slider, false)
ui.set_visible(checkbox_hitchecker, false)
ui.set_visible(in_air_roll, false)
ui.set_visible(references.roll[1], false)

local function stamina()
    return (80 - entity_get_prop(entity_get_local_player(), "m_flStamina"))
end

ui.set_visible(checkbox_hitchecker, false)
local function on_hit()
    return (entity.get_prop(entity.get_local_player(), "m_flVelocityModifier"))
end

local function hit_bind()
    local hit_health = on_hit()
    if contains(ui.get(sexy), "< Speed Velocity") then
        ui.set_visible(velocity_slider, true)
        ui.set_visible(checkbox_hitchecker, true)
        if ui.get(checkbox_hitchecker) and hit_health <= 0.9 then
            return 0
        else if is_on_ladder == 1 then
            return  0
        else
            return ui.get(velocity_slider)
            end
        end
    end
    ui.set_visible(velocity_slider, false)
    ui.set_visible(checkbox_hitchecker, false)
    return 0
end

local function Ladder_status()
    local ladd_stat = 0
    if contains(ui.get(sexy), "On Ladders") then
        if is_on_ladder == 1 then
            ladd_stat = 1
        else
            ladd_stat = 0
        end
    end
    return ladd_stat
end


local function stamina_bind()
    if contains(ui.get(sexy), "Low Stamina") then
        ui.set_visible(stamina_slider, true)
        return ui.get(stamina_slider)
    else
        ui.set_visible(stamina_slider, false)
        return 0
    end
end
local function inair()
    return (bit_band(entity_get_prop(entity_get_local_player(), "m_fFlags"), 1) == 0)
end

local function air_status()
    local air_stat = 0
    if contains(ui.get(sexy), "In Air") then
        if inair() then
            air_stat = 1
        else
            air_stat = 0
        end
    end
    return air_stat
end
local function roll_bind()
    local roll_set = ui.get(slider_roll)
    if contains(ui.get(sexy), "In Air") then
        ui.set_visible(in_air_roll, true)
    else
        ui.set_visible(in_air_roll, false)
    end
    if air_status() == 1 then
        roll_set = ui.get(in_air_roll)
    else
        return ui.get(slider_roll)
    end
        return roll_set
end


local function hide_keys()
    local key100 = 1
    if contains(ui.get(sexy), "On Key") then
        ui.set_visible(key3, true)
    else
        ui.set_visible(key3, false)
        return key100
    end
end
client.set_event_callback(
    "setup_command",
    function(e)
        local local_player = entity.get_local_player()
        if entity.get_prop(local_player, "m_MoveType") == 9 then
            is_on_ladder = 1
        else
            is_on_ladder = 0
        end
    end
)
local is_rolling = false
local function on_run_command(cmd)
    hide_keys()
    local speed = velocity()
    local recovery = stamina()
    if air_status() == 0 and not ui.get(key3) and speed >= hit_bind() and recovery >= stamina_bind() and Ladder_status() == 0 then
        is_rolling = false
        return
    end
    is_rolling = true
    stamina_bind()
    hit_bind()
    local pUserCmd = g_pInput.vfptr.GetUserCmd(ffi.cast("uintptr_t", g_pInput), 0, cmd.command_number)

    pUserCmd.viewangles.roll = roll_bind()

end






client.set_event_callback("run_command", on_run_command)
client.set_event_callback("setup_command", on_setup_command)

client.set_event_callback("shutdown", function()
    ui.set_visible(references.roll[1], true)
end)
--rolls




--indi
local refs = {
    dt = { ui_reference("RAGE", "Other", "Double tap") },
    fd = ui_reference("RAGE", "Other", "Duck peek assist"),
    baim = ui_reference  ("RAGE", "Other", "Force body aim"),
    safe = ui_reference("RAGE", "Aimbot", "Force safe point"),
    hs = { ui_reference("AA", "Other", "On shot anti-aim") },
}


function charged(delay)
    local me = entity.get_local_player()
    if me == nil or not entity.is_alive(me) then return false end
    local weapon = entity.get_prop(me, "m_hActiveWeapon")
    if weapon == nil then return false end
    local next_attack = entity.get_prop(me, "m_flNextAttack") + delay
    local next_primary_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") + delay * 2
    if next_attack == nil or next_primary_attack == nil then return false end
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end



lerp = function(start, end_pos, time, delta)
    if (math_abs(start - end_pos) < (delta or 0.01)) then return end_pos end
    time = globals.frametime() * (time * 175) 
    if time < 0 then
      time = 0.01
    elseif time > 1 then
      time = 1
    end
    return ((end_pos - start) * time + start)
end

local global_alpha = 0
local r_lerp, r1_lerp, g_lerp, g1_lerp, b_lerp, b1_lerp, dt_anim, os_anim, baim_anim, sp_anim, fd_anim, rect_anim = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


client.set_event_callback("paint_ui", function()

local state_ind = ui.get(a_b)

local firststyle = ui.get(visuals.ind_select) == "First"
local secondstyle = ui.get(visuals.ind_select) == "Second"

ui.set_visible(visuals.fade1_label, state_ind and secondstyle)
ui.set_visible(visuals.first_gradient, state_ind and secondstyle)
ui.set_visible(visuals.fade2_label, state_ind and secondstyle)
ui.set_visible(visuals.second_gradient, state_ind and secondstyle)

ui.set_visible(visuals.ind_select, state_ind)
ui.set_visible(visuals.ind_label, state_ind and firststyle)
ui.set_visible(visuals.ind_clr, state_ind and firststyle)
ui.set_visible(visuals.rect_label, state_ind and firststyle)
ui.set_visible(visuals.rect_clr, state_ind and firststyle)
ui.set_visible(visuals.cross_label, state_ind and firststyle)
ui.set_visible(visuals.cross_clr, state_ind and firststyle)

end)


local function indicators()
    local alpha = math.min(math.floor(math.sin((globals.realtime() % 3) * 4) * 125 + 200), 255)
    local w, h = client_screen_size()
    local center = {w / 2, (h / 2) + 20}
    local cx, cy = w / 2, h / 2
    local clr = { ui.get(visuals.ind_clr) }
    local clr2 = { ui.get(visuals.rect_clr) }
    local clr3 = { ui.get(visuals.cross_clr) }
    local fade1clr = { ui.get(visuals.first_gradient) }
    local fade2clr = { ui.get(visuals.second_gradient) }
    local body_yaw = (math.min(57, (entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60)));
    local line_width = math.abs(math.floor(body_yaw + 0.5))
    local offset = 0


    dt_anim = lerp(dt_anim , ui_get(refs.dt[2]) and 1 or 0 , 0.045 ,0.05)
    os_anim = lerp(os_anim , ui_get(refs.hs[2]) and 1 or 0 , 0.045 ,0.05)
    baim_anim=lerp(baim_anim , ui_get(refs.baim) and 1 or 0 , 0.045 , 0.05)
    sp_anim = lerp(sp_anim , ui_get(refs.safe) and 1 or 0 , 0.045 ,0.05)
    fd_anim = lerp(fd_anim , ui_get(refs.fd) and 1 or 0 , 0.045 ,0.05)
    r_lerp  = lerp(r_lerp , body_yaw > 0 and clr[1] or 255 , 0.1 ,0.05)
    g_lerp  = lerp(g_lerp , body_yaw > 0 and clr[2] or 255 , 0.1 ,0.05)
    b_lerp  = lerp(b_lerp , body_yaw > 0 and clr[3] or 255 , 0.1 ,0.05)
    r1_lerp = lerp(r1_lerp , body_yaw <= 0 and clr[1] or 255 , 0.1 ,0.05)
    g1_lerp = lerp(g1_lerp , body_yaw <= 0 and clr[2] or 255 , 0.1 ,0.05)
    b1_lerp = lerp(b1_lerp , body_yaw <= 0 and clr[3] or 255 , 0.1 ,0.05)
    rect_anim = lerp(rect_anim , (math.abs(body_yaw) / 58), 0.05)

    local should_work = true

    if not ui.get(a_b) then should_work = false end

    if should_work then
        global_alpha = lerp(global_alpha , 1 , 0.045 ,0.05)
    else
        global_alpha = lerp(global_alpha , 0 , 0.045 , 0.05)
    end

    if global_alpha < 0.01  then return end

    local first = "KRIPSI"
    local second = "AA"

    local ind_size = { renderer_measure_text("cb", "KRIPSI AA") };


    if ui.get(visuals.ind_select) == "First" then

    renderer_text(center[1] - (ind_size[1] / 2) + 20, center[2], r_lerp, g_lerp, b_lerp, clr[4] * global_alpha, "cb", 0, first)
    renderer_text(center[1] + (ind_size[1] / 2) - 6, center[2], r1_lerp, g1_lerp, b1_lerp, clr[4] * global_alpha, "cb", 0, second)

    renderer.rectangle(center[1] - (ind_size[1] / 2) + 1, center[2] + 7, ind_size[1] + 2, 4, 20, 20, 20, clr2[4] * global_alpha);
    renderer.rectangle(center[1] - (ind_size[1] / 2) + 2, center[2] + 8, ind_size[1], 1, 0, 0, 0, clr2[4] * global_alpha);
    renderer.rectangle(center[1] - (ind_size[1] / 2) + 2, center[2] + 8, (ind_size[1]) * rect_anim, 2, clr2[1], clr2[2], clr2[3], clr2[4] * global_alpha)


    

    if dt_anim ~= 0 then
        renderer_text(center[1], center[2] + 15 + offset, ui_get(refs.dt[2]) and (charged(0.15) and clr3[1] or 255) or 255, ui_get(refs.dt[2]) and (charged(0.15) and clr3[2] or 25) or 255, ui_get(refs.dt[2]) and (charged(0.15) and clr3[3] or 25) or 255, (ui_get(refs.dt[2]) and 255 * global_alpha * dt_anim or 100 * global_alpha * dt_anim) , "-c", 0, "DT")
        offset = offset + math_min(8, dt_anim * 9)
    end

    if os_anim ~= 0 then
        renderer_text(center[1], center[2] + 15 + offset, clr3[1], clr3[2], clr3[3], clr3[4] * global_alpha * os_anim, "-c", 0, "OS")
        offset = offset + math_min(8, os_anim * 9)
    end

    if baim_anim ~= 0 then
        renderer_text(center[1], center[2] + 15 + offset, clr3[1], clr3[2], clr3[3], clr3[4] * global_alpha * baim_anim, "-c", 0, "BAIM")
        offset = offset + math_min(8, baim_anim * 9)
    end

    if sp_anim ~= 0 then
        renderer_text(center[1], center[2] + 15 + offset, clr3[1], clr3[2], clr3[3], clr3[4] * global_alpha * sp_anim, "-c", 0, "SAFE")
        offset = offset + math_min(8, sp_anim * 9)
    end

    if fd_anim ~= 0 then
        renderer_text(center[1], center[2] + 15 + offset, clr3[1], clr3[2], clr3[3], alpha * global_alpha * fd_anim, "-c", 0, "DUCK")
        offset = offset + math_min(8, fd_anim * 9)
    end
end

    if ui.get(visuals.ind_select) == "Second" then

        renderer.text(cx, cy + 30, 255, 255, 255, 255 * global_alpha, 'c', 0, string.format('%s°', line_width))
    
        renderer.gradient(cx - line_width, cy + 40, line_width, 2, fade1clr[1], fade1clr[2], fade1clr[3], fade1clr[4] * global_alpha, fade2clr[1], fade2clr[2], fade2clr[3], fade2clr[4] * global_alpha, true)
        renderer.gradient(cx, cy + 40, line_width, 2, fade2clr[1], fade2clr[2], fade2clr[3], fade2clr[4] * global_alpha, fade1clr[1], fade1clr[2], fade1clr[3], fade1clr[4] * global_alpha, true)

        renderer.text(cx, cy + 50, 255, 255, 255, 255 * global_alpha, 'c', 0, 'KRIPSI AA')
    end
end
client.set_event_callback("paint", indicators)  
--indi

client_set_event_callback("player_hurt", on_player_hurt)
client_set_event_callback("paint", on_paint)
client_set_event_callback("round_prestart", prestart)
client.set_event_callback("run_command", run_command)
client.set_event_callback("run_command1", run_command)

