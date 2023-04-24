{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-hikari = pkgs.writeShellScriptBin "wrapped-hikari" ''
    cd ~
    exec hikari
  '';
  dbus-hikari-environment = pkgs.writeTextFile {
      name = "dbus-hikari-environment";
      destination = "/bin/dbus-hikari-environment";
      execultable = true;

      text = ''
        dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
        systemctl --user pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-hyprland
        systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-hyprland
      '';
    };
  
  cfg = config.modules.desktop.wld.hikari;
in {
  options.modules.desktop.wld.hikari = {enable = mkEnableOption "Hikari";};
  config =
    mkIf cfg.enable {
      home.packages = with pkgs; [
        dbus-hikari-environment
        hikari
        swayimg
        swaybg
        wrapped-hikari
      ];
      home.sessionVariables = {
          XDG_CURRENT_DESKTOP = "wlroots";
          XDG_SESSION_DESKTOP = "wlroots";
          XDG_SESSION_TYPE = "wayland";
        };
      home.shellAliases = {};
    };
}
