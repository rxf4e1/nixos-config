{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  wrapped-hl = pkgs.writeShellScriptBin "wrapped-hl" ''
    cd ~

    export LIBSEAT_BACKEND=logind

    if [ -z $DISPLAY ]; then
      exec dbus-run-session Hyprland
    else
      echo "Hyprland is running."
    fi
  '';

  dbus-hyprland-environment = pkgs.writeTextFile {
    name = "dbus-hyprland-environment";
    destination = "/bin/dbus-hyprland-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
      systemctl --user stop pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-hyprland
      systemctl --user start pipewire pipewire-media-session \
        xdg-desktop-portal xdg-desktop-portal-hyprland
    '';
  };

  cfg = config.modules.desktop.wld.hyprland;
in {
  options.modules.desktop.wld.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dbus-hyprland-environment
      hyprland
      hyprpaper
      swayimg
      xwayland
      xorg.xprop
      wrapped-hl
    ];
    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };

    home.shellAliases = {
      x = "wrapped-hl";
    };
    # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".config/tofi/config".source = ./config/tofi.config;
  };
}
