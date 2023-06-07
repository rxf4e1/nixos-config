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
    # home.packages = with pkgs; [];
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = ( epkgs: [ epkgs.vterm ]);
    };
    services.emacs.enable = false;
  };
}
