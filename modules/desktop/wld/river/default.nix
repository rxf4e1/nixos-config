{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-hikari = pkgs.writeShellScriptBin "wrapped-river" ''
    cd ~
    exec river
  '';
  dbus-river-environment = pkgs.writeTextFile {
      name = "dbus-river-environment";
      destination = "/bin/dbus-river-environment";
      executable = true;

      text = ''
        dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
        systemctl --user pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-hyprland
        systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-hyprland
      '';
    };
  
  cfg = config.modules.desktop.wld.river;
in {
  options.modules.desktop.wld.river = {enable = mkEnableOption "River";};
  config =
    mkIf cfg.enable {
      home.packages = with pkgs; [
        dbus-river-environment
        river
        swayimg
        swaybg
        wrapped-river
      ];
      home.sessionVariables = {
          XDG_CURRENT_DESKTOP = "wlroots";
          XDG_SESSION_DESKTOP = "wlroots";
          XDG_SESSION_TYPE = "wayland";
        };
      home.shellAliases = {
          x = "wrapped-river";
        };
    };
}
