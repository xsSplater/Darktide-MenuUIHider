local mod = get_mod("MenuUIHider")

-- Один флаг - одна точка контроля
mod.is_ui_hidden = false

-- Оптимизированная функция переключения
mod.toggle_ui_hider = function()
	mod.is_ui_hidden = not mod.is_ui_hidden
	-- mod:notify(mod.is_ui_hidden and "UI Hidden" or "UI Visible")
end

-- 1. ГЛАВНЫЙ ХУК: UIManager.render
mod:hook(CLASS.UIManager, "render", function(func, self, dt, t)
	if mod.is_ui_hidden then
		-- Если UI скрыт, просто возвращаем nil
		return
	end
	return func(self, dt, t)
end)

-- 2. Дополнительный хук для UIViewHandler (меню)
mod:hook(CLASS.UIViewHandler, "draw", function(func, self, dt, t)
	if mod.is_ui_hidden then
		return
	end
	return func(self, dt, t)
end)

-- 3. Автоматическое восстановление UI
local critical_views = {
	pause_menu_view = true,
	system_menu_view = true,
	options_view = true,
	popup_menu_view = true,
	confirmation_popup_view = true
}

mod:hook_safe(CLASS.UIViewHandler, "open_view", function(self, view_name)
	if mod.is_ui_hidden and critical_views[view_name] then
		mod.is_ui_hidden = false
		mod:notify("UI restored")
	end
end)
