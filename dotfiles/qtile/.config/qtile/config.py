# La config qtile

import datetime
import json
import os
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget

from typing import List  # noqa: F401
from mywidget import MyWidget

# la touche windows
mod = "mod4"

HOME = os.getenv("HOME")


def get_wall_colors():
    wal_path = f"{HOME}/.cache/wal/colors.json"
    if os.path.exists(wal_path):
        with open(wal_path, "r") as wal_f:
            jsono = json.load(wal_f)
            return jsono
    return {"special": {"background": "#000000", "foreground": "#ffffff"}}


COLORS = get_wall_colors()
C_BAC = COLORS["special"]["background"]
C_FOR = COLORS["special"]["foreground"]


def get_c(color: int) -> str:
    """renvoie la couleur de wal"""
    if "colors" not in COLORS:
        return "#ffffff"
    return COLORS["colors"][f"color{color}"]


PULSE_NAME = "alsa_output.pci-0000_00_1b.0.analog-stereo"

class Commands:
    autorandr = ["autorandr", "-c"]
    fehbg = ["sh", "~/.fehbg"]
    alsamixer = "st -e alsamixer"
    update = "st -e yay -Syu"
    volume_up = f"pactl set-sink-volume {PULSE_NAME} +5%"
    volume_down = f"pactl set-sink-volume {PULSE_NAME} -5%"
    volume_toggle = f"pactl set-sink-mute {PULSE_NAME} toggle"
    mic_toggle = "amixer -q set Dmic0 toggle"
    screenshot_all = "zscrot"
    screenshot_window = "zscrot u"
    screenshot_selection = f"{HOME}/bin/my_screenshot"  # in ~/bin/
    brightness_up = "xbacklight -inc 10 "
    brightness_down = "xbacklight -dec 10"
    # terminal
    suspend = f"{HOME}/bin/i3exit suspend"
    # terminal = "terminator"  # or "alacritty"
    terminal = f"{HOME}/.cargo/bin/alacritty"
    webbrowser = "chromium"


commands = Commands()

def open_calendar(qtile):
    """Ouvre google calendar"""
    qtile.cmd_spawn(f"{commands.webbrowser} https://calendar.google.com/calendar/u/0/r")

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),
    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),
    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn(Commands.terminal)),
    Key([mod], "c", lazy.spawn(Commands.webbrowser)),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([], "Print", lazy.spawn(Commands.screenshot_selection)),
    # Sound
    Key([], "XF86MonBrightnessUp", lazy.spawn(Commands.brightness_up)),
    Key([], "XF86MonBrightnessDown", lazy.spawn(Commands.brightness_down)),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(Commands.volume_up)),
    Key([], "XF86AudioLowerVolume", lazy.spawn(Commands.volume_down)),
    Key([], "XF86AudioMute", lazy.spawn(Commands.volume_down)),
    # suspend
    Key([mod, "control"], "s", lazy.spawn(Commands.suspend)),
]

groups = [Group(i) for i in "qsdfuiop"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        ]
    )

layouts = [
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(margin=3),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(font="sans", fontsize=12, padding=3, foreground=get_c(3))
extension_defaults = widget_defaults.copy()


def sep():
    # return widget.sep.Sep(padding=5, linewidth=5, foreground=get_c(6))
    return widget.TextBox("-", background=C_BAC)


screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Image(scale=True, filename="~/.config/qtile/python.png"),
                widget.CurrentLayout(),
                widget.GroupBox(foreground=get_c(3)),
                widget.Prompt(),
                widget.WindowName(),
                # requires iwlib
                # (pacman -S wireless_tools | pip install --user iwlib)
                #MyWidget(update_interval=5),
                sep(),
                widget.Memory(format="😤 {MemUsed}M/{MemTotal}M"),
                sep(),
                widget.Wlan(interface="wlp2s0", format="📡{essid} {quality}/70"),
                sep(),

                # widget.CheckUpdates(
                #     update_interval=5,
                #     distro="ubuntu",
                #     execute="",
                #     colour_have_updates="FF0000",
                #     restart_indicator="🔄",
                #     custom_command="apt list --upgradable",
                # ),
                # sep(),

                widget.Systray(),
                # widget.TextBox("🔋", name="default", **widget_defaults),
                widget.BatteryIcon(),
                widget.Battery(
                    format="{char} {percent:2.0%} {hour:d}:{min:02d}", **widget_defaults
                ),
                sep(),
                widget.Volume(
                    emoji=True,
                    mute_command=Commands.volume_toggle,
                    volume_up_command=Commands.volume_up,
                    volume_down_command=Commands.volume_down,
                ),
                sep(),
                widget.Clock(format="📅 %H:%M (%d/%m)", mouse_callbacks={"Button1": open_calendar}),
                sep(),
                widget.QuickExit(default_text="️️☠️ "),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
