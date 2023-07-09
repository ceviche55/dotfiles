awful = require("awful")

AwMenu = { -- System control group
  { "Refresh", awesome.restart },
  { "Logout", function() awesome.quit() end },
  { "Suspend", function() awful.spawn.with_shell('systemctl suspend') end },
  { "Restart", function() awful.spawn.with_shell('systemctl reboot') end },
  { "Shutdown", function() awful.spawn.with_shell('systemctl poweroff') end },
}

MainMenu = awful.menu({
    items = {
        { "Awesome", AwMenu },
        { "Terminal", terminal },
        { "Files", "alacritty -e ranger" },
      }
})

