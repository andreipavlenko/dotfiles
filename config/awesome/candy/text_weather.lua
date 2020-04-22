local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local weather_temperature_symbol = "°C"

local icons = {}
icons["clear-day"] = ""
icons["clear-night"] = ""
icons["rain"] = ""
icons["snow"] = ""
icons["sleet"] = ""
icons["wind"] = ""
icons["fog"] = ""
icons["cloudy"] = ""
icons["partly-cloudy-day"] = ""
icons["partly-cloudy-night"] = ""
icons["hail"] = ""
icons["thunderstorm"] = ""
icons["tornado"] = ""

local colors = {}
colors["clear-night"] = beautiful.xcolor1
colors["clear-day"] = beautiful.xcolor3
colors["snow"] = beautiful.xcolor7
colors["cloudy"] = beautiful.xcolor7
colors["partly-cloudy-day"] = beautiful.xcolor7
colors["partly-cloudy-night"] = beautiful.xcolor7

local weather = wibox.widget.textbox("N/A")
weather.font = beautiful.nerd_font

awesome.connect_signal("evil::weather", function(temperature, summary, icon)
    local weather_icon = icons[icon] or ""
    local color = colors[icon] or beautiful.xcolor4
    local colored_icon = helpers.colorize_text(weather_icon, color)
    local description = summary.." "..temperature..weather_temperature_symbol
    weather.markup = colored_icon.."  "..description
end)

return weather
