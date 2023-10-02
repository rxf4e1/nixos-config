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
    home.packages = with pkgs; [emacs-all-the-icons-fonts];
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-git;
      extraPackages = ( epkgs: [ epkgs.vterm ]);
    };
    home.sessionVariables.EDITOR = "emacsclient";
    services.emacs.enable = false;
  };
}
