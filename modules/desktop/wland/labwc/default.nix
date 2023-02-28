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

  cfg = config.modules.desktop.labwc;
in {
  options.modules.desktop.labwc = {enable = mkEnableOption "labwc";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dbus-labwc-environment
      labwc
      tofi
      swaybg
      wl-clipboard
      xorg.xprop
      xwayland
      wlroots
      wlrctl
      wlr-randr
      wlsunset
      brightnessctl
      jaq
      lxappearance-gtk2
      matcha-gtk-theme
      papirus-maia-icon-theme
      bibata-cursors-translucent
    ];

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
  };
}
