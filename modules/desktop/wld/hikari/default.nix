{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-hikari = pkgs.writeShellScriptBin "wrapped-hikari" ''
    cd ~
    exec dbus-run-session hikari
  '';
  dbus-hikari-environment = pkgs.writeTextFile {
      name = "dbus-hikari-environment";
      destination = "/bin/dbus-hikari-environment";
      executable = true;

      text = ''
        dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY=wlroots XDG_CURRENT_DESKTOP=wlroots
        systemctl --user stop pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
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
        wrapped-hikari
      ];
      home.sessionVariables = {
          XDG_CURRENT_DESKTOP = "wlroots";
          XDG_SESSION_DESKTOP = "wlroots";
          XDG_SESSION_TYPE = "wayland";
        };
      home.shellAliases = {
          x = "wrapped-hikari";
        };
    };
}
