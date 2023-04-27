{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  machine_id = "aspire-a315";
  cfg = config.modules.terminal.shell.fish;
in {
  options.modules.terminal.shell.fish = {enable = mkEnableOption "Fish";};
  config = mkIf cfg.enable {
    # home.packages = [pkgs.ion];
    programs.fish = {
      enable = true;
      package = pkgs.fish;
      shellAliases = {
        cat = "bat";
        less = "bat --paging=always";
        sudo = "doas";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -Iv";
        ls = "lsd";
        la = "ls --long --all --no-symlink";
        lt = "ls --tree --no-symlink";

        # rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG/'#$(hostname)'";
        # rebuild-boot = "doas nixos-rebuild boot --flake $NIXOS_CONFIG/'#$(hostname)'";
        gc = "nix-collect-garbage --delete-old";
        gcd = "doas nix-collect-garbage --delete-old";

        k = "kcr edit";
      };
      plugins = [
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "63c8f8e65761295da51029c5b6c9e601571837a1";
            sha256 = "036n50zr9kyg6ad408zn7wq2vpfwhmnfwab465km4dk60ywmrlcb";
          };
        }
      ];
    };
  };
}
