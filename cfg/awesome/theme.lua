local theme = {}

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local ctp = gfs.get_configuration_dir() .. "/theme/"
local dtp = gfs.get_themes_dir()

theme.font = "SpaceMono Nerd Font 9"

theme.bg1 = "#14161A"
theme.bg2 = "#282C33"
theme.bg3 = "#4B5263"

theme.fg1 = "#CDD6E5"
theme.fg2 = "#ABB2BF"
theme.fg3 = "#5C6370"

theme.ok = "#98C379"
theme.err = "#E06B74"
theme.pri = "#61AFEF"

theme.fg_normal = theme.fg1 .. "40"
theme.fg_focus = theme.fg1
theme.fg_minimize = theme.bg3

theme.bg_normal = theme.bg1 .. "cc"
theme.bg_focus = theme.bg1
theme.bg_urgent = theme.err
theme.bg_minimize = theme.bg3
theme.bg_systray = theme.bg_normal

theme.useless_gap = dpi(5)
theme.border_width = dpi(5)

theme.border_normal = theme.bg1
theme.border_focus = theme.bg3
theme.border_marked = theme.pri

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = dtp .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = dtp .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = dtp .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = dtp .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = dtp .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = dtp .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = dtp .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = dtp .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = dtp .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = dtp .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = dtp .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = dtp .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = dtp .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = dtp .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = dtp .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = dtp .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = dtp .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = dtp .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = dtp .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = dtp .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = dtp .. "default/titlebar/maximized_focus_active.png"

theme.wallpaper = ctp .. "wall3.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = dtp .. "default/layouts/fairhw.png"
theme.layout_fairv = dtp .. "default/layouts/fairvw.png"
theme.layout_floating = dtp .. "default/layouts/floatingw.png"
theme.layout_magnifier = dtp .. "default/layouts/magnifierw.png"
theme.layout_max = dtp .. "default/layouts/maxw.png"
theme.layout_fullscreen = dtp .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = dtp .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = dtp .. "default/layouts/tileleftw.png"
theme.layout_tile = dtp .. "default/layouts/tilew.png"
theme.layout_tiletop = dtp .. "default/layouts/tiletopw.png"
theme.layout_spiral = dtp .. "default/layouts/spiralw.png"
theme.layout_dwindle = dtp .. "default/layouts/dwindlew.png"
theme.layout_cornernw = dtp .. "default/layouts/cornernww.png"
theme.layout_cornerne = dtp .. "default/layouts/cornernew.png"
theme.layout_cornersw = dtp .. "default/layouts/cornersww.png"
theme.layout_cornerse = dtp .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
