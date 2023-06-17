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
    home.packages = with pkgs; [
      (pass.withExtensions (exts: [exts.pass-otp]))
      oath-toolkit
      qrencode
      zbar
      # dmenu-wayland
    ];
    home.sessionVariables = {
      PASSWORD_STORE_DIR = "\$HOME/.password-store";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
}
