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
    home.packages = with pkgs; [
      neovim
      luajit
      luajitPackages.luarocks
      lua-language-server
      stylua
    ];

    programs.bash = {
      # initExtra = ''
      #   export EDITOR="nvim"
      # '';
      shellAliases = {
        v = "nvim -i NONE";
        nvim = "nvim -i NONE";
      };
    };
  };
}
