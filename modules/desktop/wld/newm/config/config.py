from __future__ import annotations
from typing import Callable, Any

import os
import pwd
import time
import logging

from newm.layout import Layout
from newm.helper import BacklightManager, WobRunner, PaCtl

from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)

logger = logging.getLogger(__name__)

def execute_iter(commands: tuple[str, ...]):
  for command in commands:
    os.system(f"{command} &")

def set_value(keyval, file):
  var, val = keyval.split("=")
  return f"sed -i 's/^{var}\\=.*/{var}={var}/' {file}"

def on_startup():
  INIT_SERVICE = (
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "dbus-update-activation-environment 2>/dev/null \
    && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots"
    "dunst"
    "wlsunset -l -23.5 -L -46.5"
  )
  execute_iter(INIT_SERVICE)


def on_reconfigure():
    os.system("notify-send newm \"Reloaded config\" &")

background = {
    'path': os.environ['NIXOS_CONFIG'] + '/modules/desktop/wallpapers/1.jpg',
    'time_scale': 0.125,
    'anim': False,
}

corner_radius = 0

pywm = {
  'xkb_layout': "br",
  'xkb_variant': "abnt2",
  'xkb_options': "caps:ctrl_modifier",

  'xcursor_theme': 'Sweet-cursors',
  'xcursor_size': 16,

  'encourage_csd': False,
  'texture_shaders': 'basic',
  'renderer_mode': 'pywm',
}

outputs = [
    { 'name': 'eDP-1', 'pos_x': 0, 'pos_y': 0, 'width': 1366, 'height': 768 },
    { 'name': 'virt-1', 'pos_x': -1280, 'pos_y': 0, 'width': 1280, 'height': 720 }
]

anim_time = .25
blend_time = .5

wob_runner = WobRunner("wob -a bottom -M 100")
backlight_manager = BacklightManager(anim_time=1., bar_display=wob_runner)
kbdlight_manager = BacklightManager(args="--device='*::kbd_backlight'", anim_time=1., bar_display=wob_runner)

def synchronous_update() -> None:
    backlight_manager.update()
    kbdlight_manager.update()

pactl = PaCtl(0, wob_runner)

def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    return [
        ("L-h", lambda: layout.move(-1, 0)),
        ("L-j", lambda: layout.move(0, 1)),
        ("L-k", lambda: layout.move(0, -1)),
        ("L-l", lambda: layout.move(1, 0)),
        ("L-u", lambda: layout.basic_scale(1)),
        ("L-n", lambda: layout.basic_scale(-1)),
        ("L-t", lambda: layout.move_in_stack(1)),

        ("L-H", lambda: layout.move_focused_view(-1, 0)),
        ("L-J", lambda: layout.move_focused_view(0, 1)),
        ("L-K", lambda: layout.move_focused_view(0, -1)),
        ("L-L", lambda: layout.move_focused_view(1, 0)),

        ("L-C-h", lambda: layout.resize_focused_view(-1, 0)),
        ("L-C-j", lambda: layout.resize_focused_view(0, 1)),
        ("L-C-k", lambda: layout.resize_focused_view(0, -1)),
        ("L-C-l", lambda: layout.resize_focused_view(1, 0)),

        ("L-Return", lambda: os.system("kitty -e tmux &")),
        ("L-q", lambda: layout.close_focused_view()),

        ("L-p", lambda: layout.ensure_locked(dim=True)),
        ("L-P", lambda: layout.terminate()),
        ("L-C", lambda: layout.update_config()),

        # ("L-d", lambda: os.system("~/.config/rofi/launchers/type-3/launcher.sh &")),
        ("L-d", lambda: os.system("rofi -show drun &")),
        ("L-f", lambda: layout.toggle_fullscreen()),

        ("L-", lambda: layout.toggle_overview()),

        ("XF86MonBrightnessUp", lambda: backlight_manager.set(backlight_manager.get() + 0.1)),
        ("XF86MonBrightnessDown", lambda: backlight_manager.set(backlight_manager.get() - 0.1)),
        ("XF86KbdBrightnessUp", lambda: kbdlight_manager.set(kbdlight_manager.get() + 0.1)),
        ("XF86KbdBrightnessDown", lambda: kbdlight_manager.set(kbdlight_manager.get() - 0.1)),
        ("XF86AudioRaiseVolume", lambda: pactl.volume_adj(5)),
        ("XF86AudioLowerVolume", lambda: pactl.volume_adj(-5)),
        ("XF86AudioMute", lambda: pactl.mute()),
    ]

def rules(view):
  if view.app_id == "Kitty":
    return {'blur': {'radius': 0, 'passes': 3}}
  return None

view = {
  'corner_radius': 0,
  'padding': 3,
  'fullscreen_padding': 0,
  'send_fullscreen': False,
  'accept_fullscreen': False,

  'rules': rules,

  # 'debug_scaling': True,
  'border_ws_switch': 100,
  
}

panels = {
    'lock': {
        'cmd': 'kitty -e newm-panel-basic lock',
    },
    'launcher': {
        'cmd': 'kitty -e newm-panel-basic launcher'
    },
    'top_bar': {
        'native': {
            'enabled': False,
            'texts': lambda: [
                pwd.getpwuid(os.getuid())[0],
                time.strftime("%c"),
            ],
        }
    },
    'bottom_bar': {
        'native': {
            'enabled': False,
            'texts': lambda: [
                "newm",
                "powered by pywm"
            ],
        }
    },
}

energy = {
    'idle_callback': backlight_manager.callback
}
