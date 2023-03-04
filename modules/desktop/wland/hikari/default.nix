{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  dbus-hikari-environment = pkgs.writeTextFile {
    name = "dbus-hikari-environment";
    destination = "/bin/dbus-hikari-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

      systemctl --user stop pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr

      systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
  cfg = config.modules.desktop.wland.hikari;
in {
  options.modules.desktop.wland.hikari = {enable = mkEnableOption "Hikari";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hikari
      dbus-hikari-environment
      swaybg
      swayimg
      tofi
      wl-clipboard
      xwayland
      kanshi
      wlsunset
      brightnessctl
      wlrctl
      jaq
      jq
      grim
      slurp
      slop
      sweet
      lxappearance-gtk2
    ];

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "hikari";
      XDG_SESSION_DESKTOP = "hikari";
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
      x = "wrappedhk";
    };
  };
}
