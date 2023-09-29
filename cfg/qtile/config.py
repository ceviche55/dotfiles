import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "p", lazy.spawn("/home/hamu/.config/rofi/powermenu/type-5/powermenu.sh"),
        desc="Move window focus to other window"),
    Key([mod], "space", lazy.spawn("/home/hamu/.config/rofi/launchers/type-7/launcher.sh"),
        desc="Move window focus to other window"),
    Key([mod], "v", lazy.spawn("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}' -theme ~/.config/rofi/launchers/type-7/style-4.rasi"),
        desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "period", lazy.next_screen(),
        desc='Move focus to next monitor'),
    Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),
    Key([mod], "f", lazy.window.toggle_floating(), desc='toggle floating'),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'),
]

groups = []
groupNames = ["1", "w", "2", "e", "3", "r", "4", "5"]
groupLabels = ["Gen", "S1", "Code", "S2", "Sch", "S3", "EX1", "EX2"]
groupLayouts = ["monadtall", "verticaltile", "monadtall", "verticaltile", "columns",
                "verticaltile", "monadtall", "monadtall"]

for i in range(len(groupNames)):
    groups.append(
        Group(
            name=groupNames[i],
            layout=groupLayouts[i],
            label=groupLabels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            # Super + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.to_screen(0) if i.name in '12345' else lazy.to_screen(1),
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # Super + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(
                    i.name),
            ),
        ]
    )

layoutTheme = {
    "border_width": 3,
    "margin": 10,
    "border_focus": "#ABB2BF",
    "border_normal": "#3F4550",
    "border_on_single": True,
    "ratio": 0.65,
}

layouts = [
    layout.MonadTall(**layoutTheme),
    layout.Columns(**layoutTheme),
    layout.VerticalTile(**layoutTheme),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Tile(
    #     **layoutTheme,
    #     add_on_top=False,
    #     master_length=1,
    #     ratio=0.65,
    #     shift_windows=False,
    # ),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="SpaceMono Nerd Font",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=8),
                widget.GroupBox(
                    disable_drag=True,
                    visible_groups=['1', '2', '3', '4', '5'],
                    highlight_method='block',
                    active='#CDD6E5',
                    rounded=False,
                    this_current_screen_border='#4B5263',
                    other_screen_border='#282C34',
                ),
                widget.Spacer(length=8),
                widget.WindowName(),
                widget.WidgetBox(
                    widgets=[widget.Systray()],
                    close_button_location='right',
                ),
                widget.Spacer(length=4),
                widget.CurrentLayout(),
                widget.Clock(format="| %I:%M %p | %m-%d %a"),
                widget.Spacer(length=8),
            ],
            24,
            background="#14161A",
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=2,
    border_focus="#C678DD",
    border_normal="#C678DD",
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="flameshot"),  # GPG key password entry
        Match(wm_class="arandr"),  # GPG key password entry
        Match(wm_class="qimgv"),  # GPG key password entry
        Match(wm_class="Lxappearance"),  # GPG key password entry
        Match(wm_name="Installation"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# Auto Start Script


@hook.subscribe.startup
def autostart():
    qHome = os.path.expanduser('~/.config/qtile/')
    subprocess.Popen([qHome + 'autostart.sh'])


@hook.subscribe.resume
def onWake():
    lazy.to_screen(1)
    lazy.group['w'].toscreen()
    lazy.to_screen(0)


# XXX - Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
