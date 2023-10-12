-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

------------------------------------------------------------------
-- Error handling
--
-- If there is a big problem refer to default config
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
------------------------------------------------------------------
--
------------------------------------------------------------------
-- Variable definitions
--
-- Theme folder
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Other variables
terminal = "alacritty"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Layouts
awful.layout.layouts = {
	-- awful.layout.suit.floating,
	awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
------------------------------------------------------------------

------------------------------------------------------------------
-- Menu
--
-- Create a launcher widget and a main menu
awesomeMenu = {
	{
		"Hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "Edit Config", editor_cmd .. " " .. awesome.conffile },
	{
		"Logout",
		function()
			awesome.quit()
		end,
	},
	{
		"Suspend",
		function()
			awful.spawn.with_shell("systemctl suspend")
		end,
	},
	{ "Restart", awesome.restart },
	{
		"Shutdown",
		function()
			awful.spawn.with_shell("systemctl poweroff")
		end,
	},
}

mymainmenu = awful.menu({
	items = {
		{ "Awesome Menu", awesomeMenu },
		{ "Open Terminal", terminal },
	},
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
------------------------------------------------------------------

------------------------------------------------------------------
-- Wibar
--
-- Create a textclock widget
textClock = wibox.widget({
	-- font = beautiful.barfont,
	format = "%a %b %d, %I:%M",
	refresh = 1,
	align = "center",
	valign = "center",
	widget = wibox.widget.textclock,
})

-- Create a wibox for each screen and add it
local taglistHotkeys = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end)
)

local tasklistHotkeys = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	-- Layout Icon
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		-- Change Layout by clicking
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglistHotkeys,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklistHotkeys,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- wibox.widget.systray(),
			textClock,
			s.mylayoutbox,
		},
	})
end)
------------------------------------------------------------------
--
------------------------------------------------------------------
-- Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
------------------------------------------------------------------
--
------------------------------------------------------------------
-- Key bindings
globalkeys = gears.table.join(
	-- Back and forth between tags
	awful.key({ modkey }, ",", awful.tag.viewprev),
	awful.key({ modkey }, ".", awful.tag.viewnext),

	-- Move Focus
	awful.key({ modkey }, "h", function()
		awful.client.focus.bydirection("left")
	end),
	awful.key({ modkey }, "j", function()
		awful.client.focus.bydirection("down")
	end),
	awful.key({ modkey }, "k", function()
		awful.client.focus.bydirection("up")
	end),
	awful.key({ modkey }, "l", function()
		awful.client.focus.bydirection("right")
	end),

	-- Swap Windows
	awful.key({ modkey, "Shift" }, "h", function()
		awful.client.swap.bydirection("left")
	end),
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.bydirection("down")
	end),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.bydirection("up")
	end),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.client.swap.bydirection("right")
	end),

	-- Switch Display
	awful.key({ modkey, "Control" }, ",", function()
		awful.screen.focus_relative(1)
	end),
	awful.key({ modkey, "Control" }, ".", function()
		awful.screen.focus_relative(-1)
	end),

	-- Jump to urgent tag
	awful.key({ modkey }, "u", awful.client.urgent.jumpto),

	-- Spawn Alacritty
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end),

	-- Managing Awesome
	awful.key({ modkey, "Control" }, "r", awesome.restart),
	awful.key({ modkey, "Control" }, "q", awesome.quit),

	-- Switching Layouts
	awful.key({ modkey }, "tab", function()
		awful.layout.inc(1)
	end),
	awful.key({ modkey, "Shift" }, "tab", function()
		awful.layout.inc(-1)
	end),

	-- Unminimize Windows
	awful.key({ modkey, "Control" }, "m", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end),

	-- Gui Menus: Launcher, Powermenu, and Clipboard
	awful.key({ modkey }, "space", function()
		awful.spawn.with_shell("sh /home/hamu/.config/rofi/launchers/type-7/launcher.sh")
	end),
	awful.key({ modkey }, "p", function()
		awful.spawn.with_shell("sh /home/hamu/.config/rofi/powermenu/type-5/powermenu.sh")
	end),
	awful.key({ modkey }, "v", function()
		awful.spawn.with_shell(
			"rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}' -theme ~/.config/rofi/launchers/type-7/style-4.rasi"
		)
	end),
	awful.key({}, "Print", function()
		awful.spawn.with_shell("flameshot gui")
	end)
)

clientkeys = gears.table.join(
	-- Window Maximize
	awful.key({ modkey, "Shift" }, "f", function(c)
		c.maximized = not c.maximized
		c:raise()
	end),

	-- Window Maximize Vertical
	awful.key({ modkey, "Control" }, "f", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end),

	-- Make a window sticky
	awful.key({ modkey, "Shift" }, "s", function(c)
		c.sticky = not c.sticky
		c:raise()
	end),

	-- Close Window
	awful.key({ modkey, "Shift" }, "q", function(c)
		c:kill()
	end),

	-- Toggle window floating
	awful.key({ modkey }, "f", awful.client.floating.toggle),

	-- Move window to master
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end),

	-- Minimize window
	awful.key({ modkey }, "m", function(c)
		c.minimized = true
	end)
)

-- Loop to bind all numbers to tags.
for i = 1, 5 do
	globalkeys = gears.table.join(
		globalkeys,
		-- Jump to tag
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end),
		-- View multiple tags
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end),
		-- Move client/window to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end),
		-- Show Client on Multiple tags
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	-- Focus windows clicked on
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),

	-- Make float and move windows with left clicking and dragging
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),

	-- Make float and resize with right clicking and dragging
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
------------------------------------------------------------------
--
------------------------------------------------------------------
-- Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			size_hints_honor = false,
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},
	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"feh",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },
}
------------------------------------------------------------------
--
------------------------------------------------------------------
-- Signals
--
-- Signal functions execute when a new client appears.
client.connect_signal("manage", function(c)
	if not awesome.startup then
		awful.client.setslave(c)
	end
	-- Prevent clients from being unreachable after screen count changes.
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- If a window is floating then it stays on top
client.connect_signal("property::floating", function(c)
	if not c.fullscreen then
		if c.floating then
			c.ontop = true
		else
			c.ontop = false
		end
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
------------------------------------------------------------------
--
------------------------------------------------------------------
-- Autostart Script
awful.spawn.with_shell("sh ~/.config/awesome/startup.sh")
--
--TODO: Bring the hotkey menu backslash
