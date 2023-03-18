{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  dbus-hyprland-environment = pkgs.writeTextFile {
    name = "dbus-hyprland-environment";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
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
    # Theming
    sweet
    lxappearance-gtk2
  ];

  cfg = config.modules.desktop.wld.hyprland;
in {
  options.modules.desktop.wld.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        dbus-hyprland-environment
        rofi-wayland
        swayimg
        swaybg
        eww-wayland
        wl-clipboard
        xwayland
        wlroots
        # wlr-randr
        kanshi
        wlsunset
        xorg.xprop
        brightnessctl
        jq
      ]
      ++ utils;

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
      GDK_SCALE = "2";
      CLUTTER_BACKEND = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_FORCE_DPI = "physical";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBSEAT_BACKEND = "logind";
    };

    programs.bash.shellAliases = {
      x = "wrapped-hl";
    };

    # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".config/tofi/config".source = ./config/tofi.config;
  };
}