{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.wld.sway;
in {
  options.modules.desktop.wld.sway = {enable = mkEnableOption "Sway";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sway
      swaybg
      swayimg
      swaycwd
      eww-wayland
      waybar
      cliphist
      wob
      wl-clipboard
      wlsunset
      kanshi
      inotify-tools
      rofi-wayland
      sweet
      lxappearance-gtk2
      # brightnessctl
      playerctl
      sway-contrib.grimshot
      grim
      slurp
      jq
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
      QT_QPA_PLATFORM = "wayland-egl";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBSEAT_BACKEND = "logind";
    };

    programs.bash.shellAliases = {
      x = "wrapped-sway";
    };
  };
}
