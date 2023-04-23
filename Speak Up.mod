return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Speak Up` encountered an error loading the Darktide Mod Framework.")

		new_mod("Speak Up", {
			mod_script       = "Speak Up/scripts/mods/Speak Up/Speak Up",
			mod_data         = "Speak Up/scripts/mods/Speak Up/Speak Up_data",
			mod_localization = "Speak Up/scripts/mods/Speak Up/Speak Up_localization",
		})
	end,
	packages = {},
}
