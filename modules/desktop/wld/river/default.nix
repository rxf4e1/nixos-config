{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-river = pkgs.writeShellScriptBin "wrapped-river" ''
    cd ~

    export GTK_USE_PORTAL=0

    # XKB_DEFAULT_MODEL= 
    export XKB_DEFAULT_LAYOUT=br
    export XKB_DEFAULT_VARIANT=abnt2
    export XKB_DEFAULT_OPTIONS=ctrl:nocaps

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
        xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-wlr
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
