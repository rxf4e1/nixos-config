{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.wld.sway;
in {
  options.modules.desktop.wld.sway = {enable = mkEnableOption "Sway";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sway
      swaybg
      swayimg
      swaycwd
      glfw-wayland
      sway-contrib.grimshot
      viewnior
    ];

    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    };

    programs.bash.shellAliases = {
      x = "wrapped-sway";
    };
  };
}
