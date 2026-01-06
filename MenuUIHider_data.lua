local mod = get_mod("MenuUIHider")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "ui_hider_keybind",
				type = "keybind",
				keybind_global = true,
				default_value = {},
				keybind_trigger = "pressed",
				keybind_type = "function_call",
				function_name = "toggle_ui_hider"
			}
		}
	}
}