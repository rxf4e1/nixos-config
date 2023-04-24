{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.neovim;
in {
  options.modules.editor.neovim = {enable = mkEnableOption "Neovim";};
  config = mkIf cfg.enable {
    home.packages = [pkgs.neovim];
    home.sessionVariables.EDITOR = "nvim";
    home.shellAliases = {
      v = "nvim -i NONE";
      vim = "nvim -i NONE";
      nvim = "nvim -i NONE";
    };
  };
}
