{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.starship;
in {
  options.modules.starship = {enable = mkEnableOption "Starship Prompt";};
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      # settings = {
      #   format = lib.concatStrings [
      #     "$username"
      #     "$hostname"
      #     "$directory"
      #     "$git_branch"
      #     "$git_state"
      #     "$git_status"
      #     "$cmd_duration"
      #     "$line_break"
      #     "$nix_shell"
      #     "$character"
      #   ];
      #   directory = {
      #     truncation_length = 2;
      #     format = "[$path]($style)[$read_only]($read_only_style) ";
      #     style = "blue";
      #   };
      #   character = {
      #     success_symbol = "[❯](purple)";
      #     error_symbol = "[❯](red)";
      #     vimcmd_symbol = "[❮](green)";
      #   };
      #   git_branch = {
      #     format = "[$branch]($style)";
      #     style = "bright-black";
      #   };
      #   git_status = {
      #     format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
      #     style = "cyan";
      #     conflicted = "​";
      #     untracked = "​";
      #     modified = "​";
      #     staged = "​";
      #     renamed = "​";
      #     deleted = "​";
      #     stashed = "≡";
      #   };
      #   git_state = {
      #     format = "\([$state( $progress_current/$progress_total)]($style)\) ";
      #     style = "bright-black";
      #   };
      #   cmd_duration = {
      #     format = "[$duration]($style) ";
      #     style = "yellow";
      #   };
      #   nix_shell = {
      #     # disabled = true;
      #     impure_msg = "[impure shell](bold red)";
      #     pure_msg = "[pure shell](bold green)";
      #     unknown_msg = "[unknown shell](bold yellow)";
      #     format = "via [☃️ $state( \($name\))](bold blue) ";
      #     style = "bright-black";
      #   };
      # };
    };
  };
}