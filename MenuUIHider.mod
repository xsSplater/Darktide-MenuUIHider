return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`MenuUIHider` encountered an error loading the Darktide Mod Framework.")

		new_mod("MenuUIHider", {
			mod_script       = "MenuUIHider/MenuUIHider",
			mod_data         = "MenuUIHider/MenuUIHider_data",
			mod_localization = "MenuUIHider/MenuUIHider_localization",
		})
	end,
	packages = {},
}
