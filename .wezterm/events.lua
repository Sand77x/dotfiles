return function(_)
    local w = require("wezterm")

    local padding = {
        left = '1cell',
        right = '1cell',
        top = '0.5cell',
        bottom = '0.5cell',
    }

    -- remove padding on nvim enter
    w.on('user-var-changed', function(window, _, name, value)
        if name == "NVIM_ENTER" then
            local overrides = window:get_config_overrides() or {}
            if value == "1" then
                overrides.window_padding = {
                    left = 0,
                    right = 0,
                    top = 0,
                    bottom = 0
                }
            else
                overrides.window_padding = padding
            end
            window:set_config_overrides(overrides)
        end
    end)
end
