local mod = get_mod("Speak Up")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = true,
   options = {
      widgets = {         
      {
        setting_id = "ducking_volume",
        type = "numeric",
        range = { 1, 100 },
        default_value = 20,
        decimals_number = 0,
        step_size_value = 1,
        },
    }
  }
}
