{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.secret.pass;
in {
  options.modules.secret.pass = {enable = mkEnableOption "pass";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [passExtensions.pass-otp];
    programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "$HOME/.dotfiles/.sensitive/password-store";
        PASSWORD_STORE_CLIP_TIME = "60";
      };
    };
  };
}
