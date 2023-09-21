{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.prompt.starship;
in {
  options.modules.terminal.prompt.starship = {enable = mkEnableOption "Starship Prompt";};
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      # enableIonIntegration = true;
      enableNushellIntegration = true;
      # enableZshIntegration = true;
      # settings = {
      #   format = lib.concatStrings [
      #     "$username"
      #     "$hostname"
      #     "$directory"
      #     "$git_branch"
      #     "$git_status"
      #     "$cmd_duration"
      #     "$line_break"
      #     "$character"
      #   ];
      #   character = {
      #     # success_symbol = "[>](bold green)";
      #     # error_symbol = "[x](bold red)";
      #     # vimcmd_symbol = "[<](bold green)";
      #     success_symbol = "[❯](purple)";
      #     error_symbol = "[❯](red)";
      #     vimcmd_symbol = "[❮](green)";
      #   };
      #   directory.style = "blue";
      #   git_branch = {
      #     format = "[$branch]($style)";
      #     style = "bright-black";
      #   };
      #   git_status = {
      #     format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
      #     style = "cyan";
      #     conflicted = "";
      #     untracked = "";
      #     modified = "";
      #     staged = "";
      #     renamed = "";
      #     deleted = "";
      #     stashed = "≡";
      #   };
      #   git_state = {
      #     format = "\([$state( $progress_current/$progress_total)]($style)\)";
      #     style = "bright-black";
      #   };
      #   cmd_duration = {
      #     format = "[$duration]($style)";
      #     style = "yellow";
      #   };
      #   shell = {
      #     disabled = false;
      #     bash_indicator = " ";
      #   };
      #   nix_shell = {
      #     disabled = true;
      #     symbol = "  ";
      #   };
      #   # os.symbols.NixOS = "  ";
      # };
    };
  };
}
