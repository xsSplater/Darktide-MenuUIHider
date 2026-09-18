-- MenuUIHider.lua

local mod = get_mod("MenuUIHider")

-- Local flag cache
local is_ui_hidden = false
mod.is_ui_hidden = is_ui_hidden

mod.toggle_ui_hider = function()
	is_ui_hidden = not is_ui_hidden
	mod.is_ui_hidden = is_ui_hidden
	-- mod:notify(is_ui_hidden and "UI Hidden" or "UI Visible")
end

mod.on_settings_reset = function()
	is_ui_hidden = false
	mod.is_ui_hidden = false
end

-- 1. Main hook: UIManager.render
mod:hook(CLASS.UIManager, "render", function(func, self, dt, t)
	if is_ui_hidden then
		return
	end
	return func(self, dt, t)
end)

-- 2. Additional hook for UIViewHandler
mod:hook(CLASS.UIViewHandler, "draw", function(func, self, dt, t)
	if is_ui_hidden then
		return
	end
	return func(self, dt, t)
end)

-- 3. Automatic UI recovery
local critical_views = {
	pause_menu_view = true,
	system_menu_view = true,
	options_view = true,
	popup_menu_view = true,
	confirmation_popup_view = true,
}

mod:hook(CLASS.UIViewHandler, "open_view", function(func, self, view_name, ...)
	if is_ui_hidden and critical_views[view_name] then
		is_ui_hidden = false
		mod.is_ui_hidden = false
		mod:notify("UI restored")
	end
	return func(self, view_name, ...)
end)
