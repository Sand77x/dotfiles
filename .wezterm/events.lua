return function(_)
    local w = require("wezterm")
    local backgrounds = {
        w.config_dir .. "\\backgrounds\\shinobuflipped.jpg",
        w.config_dir .. "\\backgrounds\\aesthetic.jpg",
        w.config_dir .. "\\backgrounds\\redsun.jpg",
        w.config_dir .. "\\backgrounds\\ocean.png",
    }

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

    -- cycle through backgrounds when making new windows
    w.on('window-config-reloaded', function(window, _)
        local overrides = window:get_config_overrides() or {}
        overrides.background = {
            {
                source = {
                    File = backgrounds[window:window_id() % #backgrounds + 1]
                },
                attachment = "Fixed",
                width = "Cover",
                vertical_align = "Middle",
                horizontal_align = "Right",
            },
            {
                source = {
                    Color = "black"
                },
                width = "100%",
                height = "100%",
                opacity = 0.8,
            },
        }

        window:set_config_overrides(overrides)
    end)
end
