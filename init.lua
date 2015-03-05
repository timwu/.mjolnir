local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"

function relocate_window(full_height)
    local win = window.focusedwindow()
    local f = win:frame()
    local s = win:screen():frame()

    local top_half = math.min(f.y + f.h, s.h / 2) - f.y
    local bottom_half = math.min(f.y + f.h, s.h) - math.max(f.y, s.h / 2)
    local left_half = math.min(f.x + f.w, s.w / 2) - f.x
    local right_half = math.min(f.x + f.w, s.w) - math.max(f.x, s.w / 2)

    if full_height then
        if left_half > right_half then
            win:movetounit({ x = 0, y = 0, w = 0.5, h = 1.0 })
        else
            win:movetounit({ x = 0.5, y = 0, w = 0.5, h = 1 })
        end
    else
        local move = { x = 0, y = 0, w = 0.5, h = 0.5 }
        if right_half > left_half then
            move.x = 0.5
        end
        if bottom_half > top_half then
            move.y = 0.5
        end
        win:movetounit(move)
    end
end

hotkey.bind({ "cmd", "ctrl" }, "A", function()
    relocate_window(true)
end)

hotkey.bind({ "cmd", "ctrl" }, "S", function()
    relocate_window(false)
end)