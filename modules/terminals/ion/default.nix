{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.terminal.shell.ion;
in {
  options.modules.terminal.shell.ion = {enable = mkEnableOption "ion";};
  config = mkIf cfg.enable {
    home.packages = [
      # pkgs.ion
      pkgs.nushellFull
    ];

    # programs.ion = {
    #   enable = true;
    #   package = pkgs.ion;
    #   shellAliases = {
    #     cat = "bat";
    #     less = "bat --paging=always";
    #     sudo = "doas";
    #     cp = "cp -iv";
    #     mv = "mv -iv";
    #     rm = "rm -Iv";
    #     ls = "lsd";
    #     la = "ls --long --all --no-symlink";
    #     lt = "ls --tree --no-symlink";

    #     # rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG/'#$(hostname)'";
    #     # rebuild-boot = "doas nixos-rebuild boot --flake $NIXOS_CONFIG/'#$(hostname)'";
    #     gc = "nix-collect-garbage --delete-old";
    #     gcd = "doas nix-collect-garbage --delete-old";

    #     k = "kcr edit";
    #   };
    #   initExtra = '''';
    # };
  };
}
