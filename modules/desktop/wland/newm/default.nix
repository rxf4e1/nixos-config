{
  inputs,
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

  utils = with pkgs; [
    # ScreenShots
    grim
    slurp
    slop
    # Theming
    sweet
    lxappearance-gtk2
  ];

  cfg = config.modules.desktop.wland.newm;
in {
  options.modules.desktop.wland.newm = {enable = mkEnableOption "newm";};
  config = mkIf cfg.enable {
    # xdg.configFile."newm/config.py".text = "$HOME/.config/newm/config.py";

    home.packages = with pkgs; [
      dbus-newm-environment
      newm
      pywm-fullscreen
      # tofi
      wofi
      swayimg
      wl-clipboard
      kanshi
      wlsunset
      brightnessctl
      jaq
    ];

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "wlroots";
      XDG_CURRENT_SESSION = "wlroots";
      XDG_SESSION_DESKTOP = "wlroots";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
      GDK_SCALE = "2";
      CLUTTER_BACKEND = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland-egl";
      QT_WAYLAND_FORCE_DPI = "physical";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      LIBSEAT_BACKEND = "logind";
    };

    home.shellAliases = {
    };

    programs.bash.shellAliases = {
      x = "wrappedn";
    };
  };
}
