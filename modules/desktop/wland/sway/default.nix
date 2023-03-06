{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  cfg = config.modules.desktop.wland.sway;
in {
  options.modules.desktop.wland.sway = {enable = mkEnableOption "Sway";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dbus-sway-environment
      sway
      swaybg
      swayimg
      wl-clipboard
      kanshi
      rofi-wayland
      sweet
      lxappearance-gtk2
      brightnessctl
      grim
      slurp
      jaq
    ];

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
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
      LIBSEAT_BACKEND = "logind";
    };

    programs.bash.shellAliases = {
      x = "wrapped-sway";
    };
  };
}
