{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  inet-tools = with pkgs; [
    inetutils
    nmap
    speedtest-cli
    wireshark
  ];

  rust-env = with pkgs; [
    rustup
    rust-analyzer
  ];

  code-tools = with pkgs; [
    pandoc
    tectonic
    cmake
    python3
    perl
    shfmt
    nodejs
    yarn
  ];

  nix-tools = with pkgs; [
    alejandra
    nix-prefetch-git
    nix-index
    rnix-lsp
  ];

  cfg = config.modules.packages;
in {
  options.modules.packages = {enable = mkEnableOption "Packages";};
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        ripgrep
        ffmpeg
        btop
        bat
        fd
        procs
        unzip
        zip
        imagemagick
        libnotify
        mpv
        killall
        pulsemixer
        lolcat
        figlet
        pcmanfm
        poppler
        zathura
      ]
      ++ code-tools
      ++ rust-env
      ++ inet-tools
      ++ nix-tools;

    programs.bash = {
      initExtra = ''
        export PATH=$(yarn global bin):$PATH
      '';
    };
  };
}
