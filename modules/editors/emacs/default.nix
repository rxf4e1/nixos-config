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
    # home.packages = with pkgs; [
    #   libtool
    #   libvterm
    #   cmake
    # ];
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages =
        ( epkgs: [
          epkgs.vterm
      #     epkgs.org
      #     epkgs.spacemacs-theme
        ]);
    };
    services.emacs.enable = true;
  };
}
