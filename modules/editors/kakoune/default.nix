{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.editor.kakoune;
in {
  options.modules.editor.kakoune = {enable = mkEnableOption "Kakoune";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kakoune
      kakoune-cr
    ];

    home.file.".config/kak/kakrc".source = ./config/kakrc;
    # home.file.".config/kak/kakrc.local".source = ./config/kakrc.local;

    programs.bash = {
      shellAliases = {
        k = "kcr edit";
        ks = "kcr shell --session";
        kl = "kcr list";
        a = "kcr attach";
      };
    };
  };
}
