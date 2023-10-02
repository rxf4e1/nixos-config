{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-sway = pkgs.writeShellScriptBin "wrapped-sway" ''
    cd ~
    # If running from tty1 start sway
    [ "$(tty)" = "/dev/tty1" ] && exec sway
  '';

  dbus-sway-environment = pkgs.writeTextFile {
      name = "dbus-sway-environment";
      destination = "/bin/dbus-sway-environment";
      executable = true;

      text = ''
        dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
        systemctl --user stop pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
      '';
    };
  
  cfg = config.modules.desktop.wld.sway;
in {
  options.modules.desktop.wld.sway = {enable = mkEnableOption "Sway";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dbus-sway-environment
      sway
      swaybg
      swayimg
      swaycwd
      lxqt.lxqt-policykit
      # xdg-user-dirs
      glfw-wayland
      sway-contrib.grimshot
      viewnior
      wrapped-sway
    ];

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    };

    home.shellAliases = {
      x = "wrapped-sway";
    };
  };
}
