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

  rust-tools = with pkgs; [
    bat
    duf
    fd
    procs
    ripgrep
    rustup
    rust-analyzer
  ];

  code-tools = with pkgs; [
    pandoc
    # tectonic
    # cmake
    python3
    # perl
    # nodejs
    # yarn
  ];

  media-tools = with pkgs; [
    imagemagick
    ffmpeg
    mpv
    pulsemixer
  ];

  file-tools = with pkgs; [
    pcmanfm
    poppler
    zathura
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
        bc
        btop
        unzip
        zip
        killall
        lolcat
        figlet
        w3m
        nb
      ]
      ++ code-tools
      ++ file-tools
      # ++ inet-tools
      ++ media-tools
      ++ rust-tools
      ++ nix-tools;
  };
}
