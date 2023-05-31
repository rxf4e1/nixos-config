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
    # wireshark
    tshark
  ];

  zig-tools = with pkgs; [
    # zig
    zls
  ];
  
  rust-tools = with pkgs; [
    bat
    duf
    fd
    procs
    ripgrep
    rustup
    gcc
  ];

  code-tools = with pkgs; [
    pandoc
    python3
    perl
    deno
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
    nil
  ];

  cfg = config.modules.packages;
in {
  options.modules.packages = {enable = mkEnableOption "Packages";};
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        bc
        btop
        htop
        ed
        rlwrap
        unzip
        zip
        killall
        lolcat
        # nb
      ]
      ++ code-tools
      ++ file-tools
      ++ inet-tools
      ++ media-tools
      ++ rust-tools
      ++ zig-tools
      ++ nix-tools;
    home.shellAliases = {
      ed = "rlwrap ed --prompt='>> '";
    };
  };
}
