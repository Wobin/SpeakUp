--[[
Title: Speak Up
Author: Wobin
Date: 24/04/2023
Repository: https://github.com/Wobin/SpeakUp
Version: 1.0
]]--

local mod = get_mod("Speak Up")

local currentSpeakers = {}

local music_volume_value_name = "options_music_slider"
local sfx_volume_value_name = "options_sfx_slider"
local default_sound_volume = 100
local currentMusic = 100
local currentSfx = 100

mod.talking = function (self, channel_handle, participant)  
    if participant.is_speaking then
      local duckTo = mod:get("ducking_volume")
      if currentSpeakers[participant.account_id] then return end      
      Wwise.set_parameter(music_volume_value_name, duckTo)
      Application.set_user_setting("sound_settings", music_volume_value_name, duckTo)
      Wwise.set_parameter(sfx_volume_value_name, duckTo)
      Application.set_user_setting("sound_settings", sfx_volume_value_name, duckTo)
      Application.save_user_settings()
      currentSpeakers[participant.account_id] = true
    else
      if currentSpeakers[participant.account_id] and not participant.is_speaking then        
        currentSpeakers[participant.account_id] = nil
        Wwise.set_parameter(music_volume_value_name, currentMusic)
        Application.set_user_setting("sound_settings", music_volume_value_name, currentMusic)
        Wwise.set_parameter(sfx_volume_value_name, currentSfx)
        Application.set_user_setting("sound_settings", sfx_volume_value_name, currentSfx)
        Application.save_user_settings()
      end
      
    end
end

Managers.event:unregister(mod, "chat_manager_participant_update")  
Managers.event:register(mod, "chat_manager_participant_update", "talking")  

mod.on_all_mods_loaded = function()
    currentMusic = 	Application.user_setting("sound_settings", music_volume_value_name) or default_sound_volume
    currentSfx = 	Application.user_setting("sound_settings", sfx_volume_value_name) or default_sound_volume    
end

mod:hook_require("scripts/settings/options/sound_settings", function(category)    
    for _,setting in ipairs(category.settings) do      
      if setting.display_name == "loc_settings_music_volume" then        
         mod:hook_safe(setting, "on_activated", function(value)
            currentMusic = value
          end)
      end
      if setting.display_name == "loc_settings_sfx_volume" then        
         mod:hook_safe(setting, "on_activated", function(value)
            currentSfx = value
          end)
      end
    end
  end)
