{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  machine_id = "aspire-a315";
  cfg = config.modules.terminal.shell.nu;
in {
  options.modules.terminal.shell.nu = {enable = mkEnableOption "Nushell";};
  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nushellFull
    ];

    # programs.nushell = {
    #   enable = true;
    #   package = pkgs.nushellFull;
    #   shellAliases = {};
    # };

    home.sessionPath = [
      "/home/rxf4e1/.local/bin"
      "/home/rxf4e1/.cargo/bin"
      "/home/rxf4e1/.cache/.bun/bin"
    ];

    home.shellAliases = {
      cat = "bat";
        cd = "gd";
        less = "bat --paging=always";
        sudo = "doas";
        pandoc = "pandoc --pdf-engine tectonic";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        du = "du -hs";
        df = "df -h";
        md = "mkdir -pv";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "rm -Iv";

        v = "nano -v";

        rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG/'#${machine_id}'";
        rebuild-boot = "doas nixos-rebuild boot --flake $NIXOS_CONFIG/'#${machine_id}'";
        gc = "nix-collect-garbage --delete-old";
        gcd = "doas nix-collect-garbage --delete-old";
  };
}
