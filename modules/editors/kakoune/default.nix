{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  # kak_open = pkgs.writeShellScriptBin ''
  #   [ $# = 1 ] && echo "evaluate-commands -client $KAK_CLIENT edit $1" | kak -p "$KAK_SESSION"
  #   if [ $# = 2 ]
  #   then
  #     [ "$1" = '+0' ] && LINE=1 || LINE=$1
  #     echo "evaluate-commands -client $KAK_CLIENT edit $2" | kak -p "$KAK_SESSION" && \
  #     echo "execute-keys -client $KAK_CLIENT ${LINE}g" | kak -p "$KAK_SESSION"
  #   fi
  # '';
  cfg = config.modules.editor.kakoune;
in {
  options.modules.editor.kakoune = {enable = mkEnableOption "Kakoune";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kakoune
      kakoune-cr
    ];
    # home.file.".config/kak/kakrc".source = ./config/kakrc;
    # home.file.".config/kak/kakrc.local".source = ./config/kakrc.local;
    # home.sessionVariables.EDITOR = "kak_open";
    home.sessionVariables.EDITOR = "kcr edit";
    home.shellAliases = {
      k = "kcr edit";
      kl = "kcr list";
      a = "kcr attach";
    };
  };
}
