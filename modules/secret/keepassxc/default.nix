{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.secret.keepassxc;
in {
  options.modules.secret.keepassxc = {enable = mkEnableOption "keepassxc";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [keepassxc];
  };
}
