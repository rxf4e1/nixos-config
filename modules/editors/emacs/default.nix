{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.emacs;
in {
  options.modules.editor.emacs = {enable = mkEnableOption "emacs";};
  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtk;
    };
  };
}
