{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  dbus-newm-environment = pkgs.writeTextFile {
    name = "dbus-newm-environment";
    destination = "/bin/dbus-newm-environment";
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

  cfg = config.modules.desktop.wland.newm;
in {
  options.modules.desktop.wland.newm = {enable = mkEnableOption "Newm";};
  config = mkIf cfg.enable {
    home.packages =
      if providePkgs
      then
        with pkgs; [
          dbus-newm-environment

          newm
          pywm-fullscreen

          tofi
          wl-clipboard

          brightnessctl
          jaq

          swayimg
          grim
          slurp
          kanshi
          sweet
          lxappearance-gtk2
        ]
      else [];
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "newm";
    XDG_SESSION_DESKTOP = "newm";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    GDK_SCALE = "2";
    WLR_NO_HARDWARE_CURSORS = 1; # Hardware cursors don't properly work inside qemu
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
    x = "start-newm -d";
  };
}
