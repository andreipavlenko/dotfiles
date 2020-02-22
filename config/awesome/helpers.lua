local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local helpers = {}

helpers.rrect = function(radius)
  return function(c, width, height)
    gears.shape.rounded_rect(c, width, height, radius)
  end
end

helpers.colorize_text = function(text, color)
    return "<span foreground='" .. color .."'>" .. text .. "</span>"
end

helpers.pwrline_wrap = function(widget, symbol, bg, bg_next)
  local w = wibox.widget {
    {
        {
          markup = helpers.colorize_text(symbol, bg),
          font = "Ubuntu Nerd Font Medium 14",
          widget = wibox.widget.textbox,
        },
        bg     = bg_next,
        widget = wibox.container.background,
    },
    {
        wibox.container.margin(widget, 5, 5),
        bg     = bg,
        fg     = beautiful.xbackground,
        widget = wibox.container.background,
    },
    layout = wibox.layout.fixed.horizontal(),
  }

  return w
end

helpers.build_powerbar = function(widgets, colors)
    local wids = gears.table.reverse(widgets)
    local powerbar = {}

    for i, v in ipairs(wids) do
        local c = colors[i]
        local nc = colors[i+1]
        local w = helpers.pwrline_wrap(v, beautiful.wibar_glyph, c, nc)
        powerbar = gears.table.join(powerbar, { w })
    end

    powerbar = gears.table.reverse(powerbar)
    powerbar.layout = wibox.layout.fixed.horizontal

    return powerbar
end

return helpers
