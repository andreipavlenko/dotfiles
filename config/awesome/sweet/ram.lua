local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")

local textbox = wibox.widget.textbox("")
textbox.font = "Ubuntu Nerd Font 8"

local ram = awful.widget.watch("cat /proc/meminfo", 10, function(widget, stdout)
  local total = stdout:match("MemTotal:%s+(%d+)")
  local free = stdout:match("MemFree:%s+(%d+)")
  local buffers = stdout:match("Buffers:%s+(%d+)")
  local cached = stdout:match("Cached:%s+(%d+)")
  local srec = stdout:match("SReclaimable:%s+(%d+)")

  local used_kb = total - free - buffers - cached - srec
  local used = math.floor(used_kb / 1024 + 0.5)

  local text = " " .. used .. "MB"
  widget.markup = helpers.colorize_text(text, beautiful.xcolor4)
end, textbox)

local widget = wibox.widget {
    ram,
    left = 5,
    right = 5,
    widget = wibox.container.margin
}

return widget