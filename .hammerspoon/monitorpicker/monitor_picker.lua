-- Centered display on the monitor under the cursor
-- Fade-in and fade-out behavior
-- ESC key to cancel
-- Timeout auto-cancel
-- Mouse click to move cursor to monitor
-- Sorted top-left to bottom-right monitor index starting from 1
-- Keyboard and click interaction (configurable)
-- Labels with monitor index (1–N)
-- Index-based monitor selection via number keys
-- Cancels on invalid input
-- monitor_picker.lua
-- monitor_picker.lua
-- monitor_picker.lua
local screen = require("hs.screen")
local canvasmod = require("hs.canvas")
local mouse = require("hs.mouse")
local eventtap = require("hs.eventtap")
local timer = require("hs.timer")
local alert = require("hs.alert")
local drawing = require("hs.drawing")

local M = {}

-- === Config ===
local config = {
    mode = "keyboard",
    showUI = true,
    highlight = {
        enabled = true,
        monitorBox = true,
        strokeColor = { white = 1, alpha = 0.9 },
        fillColor = { white = 1, alpha = 0.1 },
        strokeWidth = 4,
        cornerRadius = 16,
        duration = 0.4
    }
}

-- === Internal State ===
local canvas = nil
local clickWatcher = nil
local escWatcher = nil
local numberWatcher = nil
local timeoutTimer = nil

-- === Helpers ===
local function hexToColor(hex, defaultAlpha)
    hex = hex:gsub("#", "")
    local r, g, b, a

    if #hex == 6 then
        r = tonumber(hex:sub(1,2), 16)
        g = tonumber(hex:sub(3,4), 16)
        b = tonumber(hex:sub(5,6), 16)
        a = defaultAlpha or 1
    elseif #hex == 8 then
        r = tonumber(hex:sub(1,2), 16)
        g = tonumber(hex:sub(3,4), 16)
        b = tonumber(hex:sub(5,6), 16)
        a = tonumber(hex:sub(7,8), 16) / 255
    else
        error("Invalid hex color: " .. hex)
    end

    return {
        red = r / 255,
        green = g / 255,
        blue = b / 255,
        alpha = a
    }
end

function M.setup(userConfig)
    for key, value in pairs(userConfig) do
        if type(value) == "table" and type(config[key]) == "table" then
            for subKey, subVal in pairs(value) do
                if (subKey == "strokeColor" or subKey == "fillColor") and type(subVal) == "string" then
                    local defaultAlpha = (subKey == "strokeColor") and 0.9 or 0.1
                    config[key][subKey] = hexToColor(subVal, defaultAlpha)
                else
                    config[key][subKey] = subVal
                end
            end
        else
            config[key] = value
        end
    end
    if not config.showUI and config.mode == "click" then
        config.mode = "keyboard"
    end
end

local function fadeOutAndDelete(targetCanvas, duration, steps)
    local alphaStep = targetCanvas:alpha() / steps
    local currentStep = 0
    local t = hs.timer.doEvery(duration / steps, function()
        currentStep = currentStep + 1
        targetCanvas:alpha(math.max(0, targetCanvas:alpha() - alphaStep))
        if currentStep >= steps then
            t:stop()
            targetCanvas:delete()
        end
    end)
end

local function cancel()
    if timeoutTimer then timeoutTimer:stop(); timeoutTimer = nil end
    if clickWatcher then clickWatcher:stop(); clickWatcher = nil end
    if escWatcher then escWatcher:stop(); escWatcher = nil end
    if numberWatcher then numberWatcher:stop(); numberWatcher = nil end
    if canvas then
        fadeOutAndDelete(canvas, 0.3, 10)
        canvas = nil
    end
end

local function moveToScreen(scr)
    local f = scr:frame()
    mouse.setAbsolutePosition({ x = f.x + f.w / 2, y = f.y + f.h / 2 })
end

local function highlightMonitor(scr)
    if not config.highlight.enabled or not config.highlight.monitorBox then return end
    local f = scr:frame()
    local rect = drawing.rectangle(f)
    rect:setStrokeColor(config.highlight.strokeColor)
    rect:setFillColor(config.highlight.fillColor)
    rect:setStrokeWidth(config.highlight.strokeWidth)
    rect:setRoundedRectRadii(config.highlight.cornerRadius, config.highlight.cornerRadius)
    rect:bringToFront(true)
    rect:show()
    hs.timer.doAfter(config.highlight.duration, function() rect:delete() end)
end

function M.show()
    cancel()
    local screens = screen.allScreens()
    table.sort(screens, function(a, b)
        local af, bf = a:frame(), b:frame()
        return af.y == bf.y and af.x < bf.x or af.y < bf.y
    end)

    local currentFrame = mouse.getCurrentScreen():frame()
    local spacing, w, h = 40, 180, 120
    local count = #screens
    local totalWidth = (w + spacing) * count - spacing
    local xStart = (currentFrame.w - totalWidth) / 2
    local yTop = currentFrame.h / 2 - h / 2

    if config.showUI then
        canvas = canvasmod.new(currentFrame)
        canvas:appendElements({
            id = "bg",
            type = "rectangle",
            action = "fill",
            fillColor = { white = 0, alpha = 0.5 },
            roundedRectRadii = { xRadius = 20, yRadius = 20 }
        })
        canvas:alpha(0):show()
        canvas:alpha(1)

        for i in ipairs(screens) do
            local thisX = xStart + (i - 1) * (w + spacing)
            canvas:appendElements({
                id = "monitor" .. i,
                type = "rectangle",
                frame = { x = thisX, y = yTop, w = w, h = h },
                fillColor = { red = 0.1, green = 0.1, blue = 0.1, alpha = 0.7 },
                strokeColor = { white = 0.8, alpha = 0.3 },
                strokeWidth = 1,
                roundedRectRadii = { xRadius = 12, yRadius = 12 }
            })
            canvas:appendElements({
                id = "index" .. i,
                type = "text",
                frame = { x = thisX, y = yTop + h / 2 - 26, w = w, h = 52 },
                text = tostring(i),
                textSize = 36,
                textAlignment = "center",
                textColor = { white = 1 }
            })
        end
    end

    if config.mode == "click" or config.mode == "both" then
        clickWatcher = eventtap.new({ eventtap.event.types.leftMouseDown }, function(e)
            if not config.showUI then return false end
            if e:getProperty(eventtap.event.properties.mouseEventButtonNumber) ~= 0 then
                alert.show("Invalid click") cancel() return true
            end
            local loc = e:location()
            for i, scr in ipairs(screens) do
                local thisX = xStart + (i - 1) * (w + spacing)
                local frame = {
                    x = currentFrame.x + thisX,
                    y = currentFrame.y + yTop,
                    w = w, h = h
                }
                if loc.x >= frame.x and loc.x <= frame.x + frame.w and loc.y >= frame.y and loc.y <= frame.y + frame.h then
                    highlightMonitor(scr)
                    moveToScreen(scr)
                    alert.show("Moved to Monitor " .. i)
                    cancel()
                    return true
                end
            end
            alert.show("Clicked outside monitor") cancel() return true
        end):start()
    end

    if config.mode == "keyboard" or config.mode == "both" then
        numberWatcher = eventtap.new({ eventtap.event.types.keyDown }, function(e)
            local index = tonumber(e:getCharacters())
            if index and index >= 1 and index <= #screens then
                highlightMonitor(screens[index])
                moveToScreen(screens[index])
                alert.show("Moved to Monitor " .. index)
                cancel()
                return true
            else
                alert.show("Invalid key") cancel() return true
            end
        end):start()
    end

    escWatcher = eventtap.new({ eventtap.event.types.keyDown }, function(e)
        if e:getKeyCode() == 53 then alert.show("Cancelled") cancel() return true end
        return false
    end):start()

    timeoutTimer = timer.doAfter(10, function()
        alert.show("Timed out")
        cancel()
    end)
end

return M
