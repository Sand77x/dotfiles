local wezterm = require "wezterm"
local a = wezterm.action

-- https://github.com/wez/wezterm/discussions/2426#discussioncomment-3426491
local variable_c = wezterm.action_callback(function(window, pane)
    local selection_text = window:get_selection_text_for_pane(pane)
    local is_selection_active = string.len(selection_text) ~= 0
    if is_selection_active then
        window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(a.ClearSelection, pane)
    else
        window:perform_action(wezterm.action.SendKey { key = "c", mods = "CTRL" }, pane)
    end
end)

local ctrl_keys = {
    ["v"] = a.PasteFrom "Clipboard",
    ["y"] = a.ActivateCopyMode,
    ["Enter"] = a.QuickSelect,
    ["/"] = a.Search { CaseSensitiveString = "" },
    ["s"] = a.SpawnWindow,
    ["c"] = variable_c
}

return function(config)
    config.keys = {
    }

    for key, action in pairs(ctrl_keys) do
        table.insert(config.keys, { key = key, mods = "CTRL", action = action })
    end
end
