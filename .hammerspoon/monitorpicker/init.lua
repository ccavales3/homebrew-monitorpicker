-- Load your monitor picker module
local monitor_picker = require("monitorpicker.monitor_picker")

monitor_picker.setup({
    mode = "both",       -- "keyboard", "click", or "both"
    showUI = true,       -- false = no UI (click mode will auto-disable)
    highlight = {
        enabled = true,
        monitorBox = true,  -- Set to false to disable monitor outline
        strokeColor = "#FFFFFF",    -- orange, with default alpha = 0.9
        fillColor = "#FFFFFF",    -- orange, alpha ~25%
        strokeWidth = 5,
        cornerRadius = 16,
        duration = 0.4
    }
})

-- Bind hotkey: Cmd + Ctrl + Space
hs.hotkey.bind({"cmd", "ctrl"}, "space", function()
    monitor_picker.show()
end)

-- Optional: Show a notification when config is loaded
hs.alert.show("Hammerspoon loaded: Monitor Picker Ready")
