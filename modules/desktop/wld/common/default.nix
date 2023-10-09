{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.wld.common;
in {
  options.modules.desktop.wld.common = {enable = mkEnableOption "Common";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cliphist
      jq
      kanshi
      # rofi-wayland
      fuzzel
      playerctl
      wl-clipboard
      wlsunset
      libinput
      swaybg
      swayimg
    ];

    home.sessionVariables = {
      GDK_BACKEND = "wayland";
      GDK_SCALE = "1";
      CLUTTER_BACKEND = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland-egl";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBSEAT_BACKEND = "logind";
    };
  };
}
