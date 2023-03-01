{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  dbus-labwc-environment = pkgs.writeTextFile {
    name = "dbus-labwc-environment";
    destination = "/bin/dbus-labwc-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Labwc
      systemctl --user stop pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  utils = with pkgs; [
    # ScreenShots
    grim
    slurp
    slop
    jq
    # Theme
    sweet
    lxappearance-gtk2
  ];

  cfg = config.modules.desktop.wland.labwc;
in {
  options.modules.desktop.wland.labwc = {enable = mkEnableOption "LabWC";};
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        dbus-labwc-environment
        labwc
        tofi
        bemenu
        swaybg
        wl-clipboard
        xorg.xprop
        xwayland
        wlroots
        wlrctl
        kanshi
        wlsunset
        brightnessctl
        jaq
      ]
      ++ utils;

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "wlroots";
      XDG_SESSION_DESKTOP = "wlroots";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
      GDK_SCALE = "2";
      CLUTTER_BACKEND = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    home.shellAliases = {
      x = "wrappedlab";
    };
  };
}
