{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-river = pkgs.writeShellScriptBin "wrapped-river" ''
    cd ~

    # export GTK_USE_PORTAL=0
    export MOZ_ENABLE_WAYLAND=1

    # XKB_DEFAULT_MODEL= 
    # export XKB_DEFAULT_LAYOUT=br
    # export XKB_DEFAULT_VARIANT=abnt2
    # export XKB_DEFAULT_OPTIONS=ctrl:nocaps

    timestamp=$(date +%F-%R)

    if [ -z $DISPLAY ]; then
      exec dbus-run-session river -log-level debug > /tmp/river-$timestamp.log 2>&1
    else
      echo "RiverWM is running."
    fi
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
          XDG_CURRENT_DESKTOP = "river";
          XDG_SESSION_DESKTOP = "wlroots";
          XDG_SESSION_TYPE = "wayland";
          
          XKB_DEFAULT_LAYOUT = "br";
          XKB_DEFAULT_VARIANT = "abnt2";
          XKB_DEFAULT_OPTIONS = "ctrl:nocaps";
        };
      home.shellAliases = {
          x = "wrapped-river";
        };
    };
}
