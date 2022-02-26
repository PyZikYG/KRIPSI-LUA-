-- local variables for API functions. any changes to the line below will be lost on re-generation
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
client.color_log(21, 235, 220,  "                       Welcome " .. name .. "!            ")
client.color_log(215, 115, 222, "                      Pasted by KRIPSI#5061                 ")
client.color_log(235, 221, 21,  "                    Last Updated: 24/02/2022.               ")
client.color_log(255, 255, 255, "|--------------------------------------------------------|")
-- our menu elements :D
local label = ui.new_label("AA", "Anti-aimbot angles",'---- KRIPSI AA LUA SECTION STARTED  ----')
local label = ui.new_label("AA", "Other",'---- KRIPSI MISC LUA SECTION STARTED  ----')

local preset_choice = ui.new_combobox("AA", "Anti-aimbot angles", "Preset choice", {"Gamesense AA", "Sigma Prediction", "Acatel.us", "Tank aa", "DrainYaw", "Clown aa"})
local inverter = ui.new_hotkey("AA", "Anti-aimbot angles", "DDOS Legit aa on key")
local master = ui.new_checkbox("AA", "Anti-aimbot angles", "Roll aa Enable")
local idk = ui.new_hotkey("AA", "Anti-aimbot angles", "Roll aa on key")         
local int = ui.new_slider("AA", "Anti-aimbot angles", "Desync Exploit Value", -50   , 50, 50)
local menu = {
    enabled = ui.new_checkbox("AA", "Other", "Crosshair indicator"),
    s_offset = ui.new_slider("AA", "Other", "\nHitlog offset", -500, 500, 20, true, "px"),
    extra = ui.new_checkbox("AA", "Other", "Extra indicators"),
    color = ui.new_color_picker("AA", "Other", "Extra indicator color", 0, 255, 0, 255)
}

local ui_element = {
    enable = ui.new_checkbox("AA", "Other", 'Zeus Teleport '),
    hotkey = ui.new_hotkey("AA", "Other", 'Teleport', true),
    combo = ui.new_combobox("AA", "Other", '\n Options', {'Distance', 'Predicted distance', 'Teleport out (test)'}),
    weapons = ui.new_multiselect("AA", "Other", '\n Weapons', {'Pistol', 'SMG', 'Rifle', 'Shotgun', 'Machine gun', 'Sniper rifle', 'Taser'}),
    dist = ui.new_slider("AA", "Other", 'Min. Dist to teleport', 100, 300, 200, true, 'u', 1, { }),
    pred_dist = ui.new_slider("AA", "Other", 'Min. Pred dist to teleport', 100, 300, 240, true, 'u', 1, { }),
    pred_ticks = ui.new_slider("AA", "Other", 'Predicted Ticks', 60, 100, 75, true, 't', 1, {}),
    out_ticks = ui.new_slider("AA", "Other", 'Predicted location ticks', 0, 400, 200, true, 't', 1, {}),
}

local autosmoke = ui.new_checkbox("AA", "Other", "Auto-Smoke")
local hk_autosmoke = ui.new_hotkey("AA", "Other", "Auto-Smoke key", true)
    
local label = ui.new_label("AA", "Anti-aimbot angles",'---- KRIPSI AA LUA SECTION ENDED  ----')
local label = ui.new_label("AA", "Other",'---- KRIPSI MISC LUA SECTION ENDED  ----')


-- all aa refs
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

-- this is here for debugging or indicators whatever you want idgaf
local state = "NONE"




local function sigma_prediction_aa()
	local localplayer = entity.get_local_player()
	local flags = entity.get_prop(localplayer, "m_fFlags")
	local vx, vy = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	if ui.get(slow_walk) and ui.get(slow_walk2) then
        --slowwalk
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Offset")
        ui.set(jyawslide, math.random(0,60))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "SLOWWALK"
    elseif flags == 263 and velocity < 250 then
        --crouch
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, 7)
        ui.set(bodyyaw, "Static")
        ui.set(bodyyaw2, -95)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "CROUCH"
    elseif flags == 256 or flags == 262 or velocity > 250 then
        --air
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 35)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "AIR"
    elseif flags == 257 and velocity > 10 and velocity < 250 then
        --moving
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 60)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "MOVING"
    else
        --stand
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, 7)
        ui.set(bodyyaw, "Static")
        ui.set(bodyyaw2, -95)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "STAND"
    end
end

-- acatel.us !!!
local function acatel_us_aa()
	local localplayer = entity.get_local_player()
	local flags = entity.get_prop(localplayer, "m_fFlags")
	local vx, vy = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	if ui.get(slow_walk) and ui.get(slow_walk2) then
        --slowwalk
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
        state = "SLOWWALK"
    elseif flags == 263 and velocity < 250 then
        --crouch
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, math.random(5,-10))
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 0)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, -79)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, math.random(30,45))
        state = "CROUCH"
    elseif flags == 256 or flags == 262 or velocity > 250 then
        --air
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 25)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "AIR"
    elseif flags == 257 and velocity > 10 and velocity < 250 then
        --moving
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 79)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "MOVING"
    else
        --stand
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 25)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "STAND"
    end
end

local function sigma_prediction_aa()
	local localplayer = entity.get_local_player()
	local flags = entity.get_prop(localplayer, "m_fFlags")
	local vx, vy = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	if ui.get(slow_walk) and ui.get(slow_walk2) then
        --slowwalk
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Offset")
        ui.set(jyawslide, math.random(0,60))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "SLOWWALK"
    elseif flags == 263 and velocity < 250 then
        --crouch
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, 7)
        ui.set(bodyyaw, "Static")
        ui.set(bodyyaw2, -95)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "CROUCH"
    elseif flags == 256 or flags == 262 or velocity > 250 then
        --air
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 35)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "AIR"
    elseif flags == 257 and velocity > 10 and velocity < 250 then
        --moving
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 60)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "MOVING"
    else
        --stand
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, 7)
        ui.set(bodyyaw, "Static")
        ui.set(bodyyaw2, -95)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "STAND"
    end
end
-- tank aa !!!
local function Tank_aa()
	local localplayer = entity.get_local_player()
	local flags = entity.get_prop(localplayer, "m_fFlags")
	local vx, vy = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	if ui.get(slow_walk) and ui.get(slow_walk2) then
        --slowwalk
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
        state = "SLOWWALK"
    elseif flags == 263 and velocity < 250 then
        --crouch
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 3)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 42)
        ui.set(bodyyaw, "Static")
        ui.set(bodyyaw2, 23)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, math.random(8,12))
        state = "CROUCH"
    elseif flags == 256 or flags == 262 or velocity > 250 then
        --air
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 25)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "AIR"
    elseif flags == 257 and velocity > 10 and velocity < 250 then
        --moving
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 79)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "MOVING"
    else
        --stand
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 25)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "STAND"
    end
end

-- DrainYaw !!!
local function DrainYaw()
	local localplayer = entity.get_local_player()
	local flags = entity.get_prop(localplayer, "m_fFlags")
	local vx, vy = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	if ui.get(slow_walk) and ui.get(slow_walk2) then
        --slowwalk
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, -10)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 58)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "SLOWWALK"
    elseif flags == 263 and velocity < 250 then
        --crouch
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 60)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "CROUCH"
    elseif flags == 256 or flags == 262 or velocity > 250 then
        --air
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, -10)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Offset")
        ui.set(jyawslide, -10)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, -141)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "AIR"
    elseif flags == 257 and velocity > 10 and velocity < 250 then
        --moving
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")  
        ui.set(jyawslide, 58)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 141)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 1)
        state = "MOVING"
    else
        --stand
        ui.set(pitch, "Default")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 0)
        ui.set(yawbody, "180")
        ui.set(jyaw, "Center")
        ui.set(jyawslide, 60)
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 0)
        ui.set(freestand_byaw, false)
        ui.set(fyawlimit, 60)
        state = "STAND"
    end
end

local function Clown_aa()
	local localplayer = entity.get_local_player()
	local flags = entity.get_prop(localplayer, "m_fFlags")
	local vx, vy = entity.get_prop(localplayer, "m_vecVelocity")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
	if ui.get(slow_walk) and ui.get(slow_walk2) then
        --slowwalk
        ui.set(pitch, "Up")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 180)
        ui.set(yawbody, "Spin")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, math.random(160,180))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 180)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "SLOWWALK"
    elseif flags == 263 and velocity < 250 then
        --crouch
        ui.set(pitch, "Up")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 180)
        ui.set(yawbody, "Spin")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, math.random(160,180))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 180)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "CROUCH"
    elseif flags == 256 or flags == 262 or velocity > 250 then
        --air
        ui.set(pitch, "Up")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 180)
        ui.set(yawbody, "Spin")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, math.random(160,180))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 180)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "AIR"
    elseif flags == 257 and velocity > 10 and velocity < 250 then
        --moving
        ui.set(pitch, "Up")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 180)
        ui.set(yawbody, "Spin")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, math.random(160,180))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 180)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "MOVING"
    else
        --stand
        ui.set(pitch, "Up   ")
        ui.set(yawbase, "At targets")
        ui.set(yaw, 180)
        ui.set(yawbody, "Spin")
        ui.set(jyaw, "Random")
        ui.set(jyawslide, math.random(160,180))
        ui.set(bodyyaw, "Jitter")
        ui.set(bodyyaw2, 180)
        ui.set(freestand_byaw, true)
        ui.set(fyawlimit, 60)
        state = "STAND"
    end
end


--on_run_command
local function run_command()
	if ui.get(preset_choice) == "Gamesense AA" then
		ui.set_visible(yawbody, true)
	    ui.set_visible(yaw, true)
	    ui.set_visible(bodyyaw, true)
	    ui.set_visible(bodyyaw2, true)
	    ui.set_visible(edge, true)
	    ui.set_visible(jyaw, true)
	    ui.set_visible(jyawslide, true)
	    ui.set_visible(pitch, true)
	    ui.set_visible(yawbase, true)
	    ui.set_visible(freestanding, true)
	    ui.set_visible(freestanding2, true)
	    ui.set_visible(fyawlimit, true)
	    ui.set_visible(freestand_byaw, true)
    else
    	ui.set_visible(yawbody, false)
	    ui.set_visible(yaw, false)
	    ui.set_visible(bodyyaw, false)
	    ui.set_visible(bodyyaw2, false)
	    ui.set_visible(edge, true)
	    ui.set_visible(jyaw, false)
	    ui.set_visible(jyawslide, false)
	    ui.set_visible(pitch, false)
	    ui.set_visible(yawbase, false)
	    ui.set_visible(freestanding, true)
	    ui.set_visible(freestanding2, true)
	    ui.set_visible(fyawlimit, false)
	    ui.set_visible(freestand_byaw, false)
    end

    if ui.get(preset_choice) == "Acatel.us" then
    	acatel_us_aa()
    elseif ui.get(preset_choice) == "Sigma Prediction" then
    	sigma_prediction_aa()
    elseif ui.get(preset_choice) == "Tank aa" then
    	Tank_aa()
    elseif ui.get(preset_choice) == "DrainYaw" then
    	DrainYaw()
    elseif ui.get(preset_choice) == "Clown aa" then
    	Clown_aa()
    end
end






























--Legit aa
---------------------------------------------------

client.set_event_callback("setup_command", function(info)
    if info.in_use == 1 then 
        if info.in_grenade1 == 1 or info.in_grenade2 == 1 or info.in_attack == 1 then return end
        local cam_anglesx, cam_anglesy, cam_anglesr = client.camera_angles()
        local tick_count = globals.tickcount() % 3
        if ui.get(inverter) then
            if tick_count == 1 then
                info.yaw = cam_anglesy + 120
                info.allow_send_packet = false
            elseif tick_count == 2 then
                info.yaw = cam_anglesy - 120
                info.allow_send_packet = false
            else
                info.yaw = cam_anglesy
                info.allow_send_packet = true
            end
        else
            if tick_count == 1 then
                info.yaw = cam_anglesy - 120
                info.allow_send_packet = false
            elseif tick_count == 2 then
                info.yaw = cam_anglesy + 120
                info.allow_send_packet = false
            else
                info.yaw = cam_anglesy
                info.allow_send_packet = true
            end
        end
    end
end)







----Roll AA
local ui_get = ui.get



function desync(cmd)
    if ui_get(master)then
        local localplayer = entity.get_local_player
        local vx, vy, vz = entity.get_prop(localplayer(), 'm_vecVelocity')    
        if  math.abs(vx) < 5 and math.abs(vy) < 5 and math.abs(vz) < 5 and not ui_get(idk)then
            cmd.roll = ui_get(int)
        elseif ui_get(idk) then
            cmd.roll = ui_get(int)
        end
    end
end

client.set_event_callback('setup_command', desync)




---CRINGE INDICATORS
local w, h = client.screen_size()
local center = { w/2, h/2 }
local offset = 0
local r, g, b, a
local indicators = {}
local text_flags = "cb"



local states = {
    { { ui.reference("AA", "Anti-aimbot angles", "Freestanding") }, "FREESTANDING" },
    { { ui.reference("AA", "Other", "On shot anti-aim") }, "ONSHOT" },
    { { ui.reference("RAGE", "Other", "Force body aim") }, "FORCE BAIM" },
    { { ui.reference("RAGE", "Aimbot", "Force safe point") }, "SAFEPOINT" },
    { { ui.reference("AA", "Other", "Fake peek") }, "FAKE PEEK"},
}

local function bool_to_number(value)
    return value and 1 or 0
end

local function on_indicator(i)
    table.insert(indicators, i)
end

local function on_paint()
    for i = 1, #indicators do 
        local cur_i = indicators[i]
        local y = (offset >= 0) and (center[2] - offset - (i * 12)) or (center[2] - offset + (i * 12))
        renderer.text(center[1], y, cur_i.r, cur_i.g, cur_i.b, cur_i.a, text_flags, 0, cur_i.text)
    end

    if ui.get(menu.extra) then
        local total_states = #indicators
        for i = 1, #states do 
            local active = 0
            local cur_check = states[i][1]

            for n = 1, #cur_check do 
                local value = ui.get(cur_check[n])
                local type = type(value)
                if type == "boolean" then
                    active = active + bool_to_number(value)
                elseif type == "table" and value[1] ~= nil then 
                    active = active + 1
                end
            end
            
            if active >= #cur_check then
                total_states = total_states + 1
                local y = (offset >= 0) and (center[2] - offset - (total_states * 12)) or (center[2] - offset + (total_states * 12))
                renderer.text(center[1], y, r, g, b, a, text_flags, 0, states[i][2])
            end
        end
    end

    indicators = {}
end

local function cbx_toggle()
    local state = ui.get(menu.enabled)
    local update_callback = state and client.set_event_callback or client.unset_event_callback
    update_callback("indicator", on_indicator)
    update_callback("paint", on_paint)
    ui.set_visible(menu.extra, state)
    ui.set_visible(menu.s_offset, state)
    ui.set_visible(menu.color, state)
end

do
    ui.set_callback(menu.enabled, cbx_toggle)
    cbx_toggle()

    ui.set_callback(menu.color, function(self)
        r, g, b, a = ui.get(self)
    end)
    r, g, b, a = ui.get(menu.color)

    ui.set_callback(menu.s_offset, function(self)
        offset = ui.get(self)
    end)
    offset = ui.get(menu.s_offset)
end







--zeuusss
local vector = require 'vector'
local csgo_weapons = require 'gamesense/csgo_weapons'

local ticks_to_time = function(ticks)
    return globals.tickinterval() * ticks
end

local function is_visible(ent) -- creds to invalidcode <3
    local me = entity.get_local_player()
    local l_x, l_y, l_z = entity.hitbox_position(me, 0)
    local e_x, e_y, e_z = entity.hitbox_position(ent, 0)

    local frac, ent = client.trace_line(me, l_x, l_y, l_z, e_x, e_y, e_z)

    return frac > 0.6
end

local function get_ent_dist(ent_1, ent_2) -- creds to invalidcode <3
    local ent1_pos = vector(entity.get_prop(ent_1, 'm_vecOrigin'))
    local ent2_pos = vector(entity.get_prop(ent_2, 'm_vecOrigin'))

    local dist = ent1_pos:dist(ent2_pos)

    return dist
end

local function contains(table, key) 
    for index, value in pairs(table) do 
        if value == key then 
            return true 
        end 
    end 
    return false 
end

local function SetTableVisibility(table, state)
    for i = 1, #table do
        ui.set_visible(table[i], state)
    end
end

local dt = {ui.reference('Rage', 'Other', 'Double tap')}



local weapon_groups = {
    ['pistol'] = 'Pistol',
    ['smg'] = 'SMG',
    ['rifle'] = 'Rifle',
    ['shotgun'] = 'Shotgun',
    ['machinegun'] = 'Machine gun',
    ['sniperrifle'] = 'Sniper rifle',
    ['taser'] = 'Taser'
}

local cached_state = ui.get(dt[1])
local cache, cache_2, cache_3 = false, false, false

local function on_setup()
    if not ui.get(ui_element.hotkey) or not ui.get(ui_element.enable) then
        return
    end

    local local_player = entity.get_local_player()
    local enemies = entity.get_players(true)
    local weapon_ent = entity.get_player_weapon(local_player)
	local weapon = csgo_weapons(weapon_ent)
    if weapon == nil then return end
	if weapon_ent == nil then return end
    local ticktime = ticks_to_time(ui.get(ui_element.pred_ticks))

    ui.set(dt[1], true)

    for i, v in ipairs(enemies) do
        local lvel = vector(entity.get_prop(local_player, 'm_vecVelocity'))
        local dist = get_ent_dist(local_player, v)
        local p_dist = get_ent_dist(local_player * ticktime, v * ticktime)
        local origin = vector(entity.get_origin(v * ticktime))
        local eye_pos = vector(client.eye_position()) + (lvel * ticktime)
        local trace_line = client.trace_line(local_player, eye_pos.x, eye_pos.y, eye_pos.z, origin.x, origin.y, origin.z)

        if contains(ui.get(ui_element.weapons), weapon_groups[weapon.type]) then
            if (dist < ui.get(ui_element.dist)) and ui.get(ui_element.combo) == 'Distance' and is_visible(v) then
                ui.set(dt[1], false)
            end
    
            if (p_dist < ui.get(ui_element.pred_dist)) and ui.get(ui_element.combo) == 'Predicted distance' and is_visible(v) then
                ui.set(dt[1], false)
            end
    
            if trace_line and ui.get(ui_element.combo) == 'Teleport out (test)' then
                ui.set(dt[1], false)
            end
        end
    end
end

client.set_event_callback('paint_ui', function()
    SetTableVisibility({ui_element.combo, ui_element.weapons, ui_element.hotkey}, ui.get(ui_element.enable))
    SetTableVisibility({ui_element.dist}, ui.get(ui_element.enable) and ui.get(ui_element.combo) == 'Distance')
    SetTableVisibility({ui_element.pred_dist, ui_element.pred_ticks}, ui.get(ui_element.enable) and ui.get(ui_element.combo) == 'Predicted distance')
    SetTableVisibility({ui_element.out_ticks}, ui.get(ui_element.enable) and ui.get(ui_element.combo) == 'Teleport out (test)')
end)

local function handle_callbacks(state)
	local callback = (state) and client.set_event_callback or client.unset_event_callback
	callback('setup_command', on_setup)
end

ui.set_callback(ui_element.enable, handle_callbacks)
handle_callbacks(ui.get(ui_element.enable))


-----AUTOSMOKE
local csgo_weapons = require 'gamesense/csgo_weapons'


local in_attack2
local needed_player
local has_molly
local throwed
local can_hit_us
local throwed_smoke
local time = 0

--- kibit staff----
local math_rad  = math.rad
local math_sqrt = math.sqrt
local math_sin  = math.sin
local math_cos  = math.cos
---kibit staff---

local function vec3_dot(ax, ay, az, bx, by, bz)
	return ax*bx + ay*by + az*bz
end

local function vec3_normalize(x, y, z)
	local len = math_sqrt(x * x + y * y + z * z)
	if len == 0 then
		return 0, 0, 0
	end
	local r = 1 / len
	return x*r, y*r, z*r
end

local function angle_to_vec(pitch, yaw)
	local p, y = math_rad(pitch), math_rad(yaw)
	local sp, cp, sy, cy = math_sin(p), math_cos(p), math_sin(y), math_cos(y)
	return cp*cy, cp*sy, -sp
end

local function get_fov_cos(ent, vx,vy,vz, lx,ly,lz)
	local ox,oy,oz = entity.get_prop(ent, "m_vecOrigin")
	if ox == nil then
		return -1
	end

	-- get direction to player
	local dx,dy,dz = vec3_normalize(ox-lx, oy-ly, oz-lz)
	return vec3_dot(dx,dy,dz, vx,vy,vz)
end

------- enemy closest to crosshair by kibit------

local function get_nearest()
    local entindex = entity.get_local_player()
	if entindex == nil then return end
	local lx,ly,lz = entity.get_prop(entindex, "m_vecOrigin")
	if lx == nil then return end
    local players = entity.get_players(true)	
	local pitch, yaw = client.camera_angles()
	local vx, vy, vz = angle_to_vec(pitch, yaw)
	local closest_fov_cos = -1
    for i=1, #players do
        local idx = players[i]
		if entity.is_alive(idx) then
			local fov_cos = get_fov_cos(idx, vx,vy,vz, lx,ly,lz)
			if fov_cos > closest_fov_cos then
				closest_fov_cos = fov_cos
                needed_player = idx
			end
		end
    end
end
------- enemy closest to crosshair by kibit------




local function lp_hittable()
    if needed_player == nil then return end
	local local_player = entity.get_local_player()
	local l_x, l_y, l_z = entity.hitbox_position(local_player, 0)
	local x, y, z = entity.hitbox_position(needed_player, 0)
    local check, dmg = client.trace_bullet(needed_player, x, y, z, l_x, l_y, l_z)
    return check
end



local function on_setup_command(e)
    if not ui.get(hk_autosmoke) then return end
    get_nearest()
    local local_player = entity.get_local_player()
    local nextAttack = entity.get_prop(local_player,"m_flNextAttack") 
    nextAttack = nextAttack - globals.curtime()
    local weapon_ent = entity.get_player_weapon(local_player)
	if weapon_ent == nil then return end
	local weapon = csgo_weapons(weapon_ent)
    if weapon == nil then return end
    can_hit_us = lp_hittable()
    if weapon.idx == 45 then 
        if can_hit_us ~= nil or not has_molly and not throwed and time < globals.curtime() then
        client.exec("slot2")
        client.exec("slot1")
        time = globals.curtime() + 0.2
        --has_molly = false

        client.log("slot2") --  debug
        client.log("slot1") --  debug
        elseif nextAttack <= 0 and in_attack2 == 0 and throwed and not throwed_smoke then 
        e.allow_send_packet = true
        e.pitch = 89
        e.in_attack2 = 1
        e.forwardmove = 0
        e.sidemove = 0  
        client.delay_call(0.12, function ()
            throwed = false
        end)
        client.log("throwed")
        end
    else
        if can_hit_us == nil and has_molly and time < globals.curtime() then
        client.exec("use weapon_smokegrenade") 
        time = globals.curtime() + 0.2
        client.log("use weapon_smokegrenade") --  debug
        end
    end
    in_attack2 = e.in_attack2
end

local function on_item_equip(e)
    if not ui.get(hk_autosmoke) then return end
    local victim = client.userid_to_entindex(e.userid)
    if victim ~= needed_player then return end
    if e.item == "molotov" or e.item == "incgrenade" then
        has_molly = true
    elseif has_molly then
        has_molly = false
    end
end

local function on_grenade_thrown(e)
    if not ui.get(hk_autosmoke) then return end
    local victim = client.userid_to_entindex(e.userid)
    if victim == needed_player and e.weapon == "molotov" or e.weapon == "incgrenade" then throwed = true 
    client.delay_call(5, function ()
        throwed = false
    end)
    elseif victim == entity.get_local_player() and e.weapon == "smokegrenade" then throwed_smoke = true
    client.delay_call(5, function ()
        throwed_smoke = false
    end)
    end
end


local function on_paint(e)
    if not ui.get(hk_autosmoke) then return end
    local r,g,b 
    if throwed then r,g,b = 247,12,12 else r,g,b = 0,230,255 end
    renderer.indicator(r,g,b,255, "AUTOSMOKE")
end


ui.set_callback(autosmoke, function()
    if ui.get(autosmoke) then
        client.set_event_callback("setup_command", on_setup_command)
        client.set_event_callback("item_equip", on_item_equip)
        client.set_event_callback("grenade_thrown", on_grenade_thrown)
        client.set_event_callback("paint", on_paint)
	else
		client.unset_event_callback("setup_command", on_setup_command)
        client.unset_event_callback("item_equip", on_item_equip)
        client.unset_event_callback("grenade_thrown", on_grenade_thrown)
        client.unset_event_callback("paint", on_paint)
	end
end)









--callbacks
client.set_event_callback("run_command", run_command)       
