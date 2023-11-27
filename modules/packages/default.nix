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
    # searxng
  ];

  zig-tools = with pkgs; [
    zig
    zig-shell-completions
    zls
    ztags
  ];

  rust-tools = with pkgs; [
    bat
    duf
    fd
    procs
    ripgrep
    rustup
  ];

  c-tools = with pkgs; [
    cmake
    gcc
  ];

  lua-tools = with pkgs; [
    lua54Packages.lua
    lua54Packages.luarocks
    lua-language-server
  ];

  code-tools = with pkgs; [
    gdb
    pandoc
    python3
    perl
    bun
    # deno
    # nodejs
  ];

  media-tools = with pkgs; [
    imagemagick
    ffmpeg_5-full
  ];

  file-tools = with pkgs; [
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
    manual.manpages.enable = false;
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
        weechat
      ]
      ++ code-tools
      ++ file-tools
      ++ inet-tools
      ++ media-tools
      ++ rust-tools
      ++ zig-tools
      ++ c-tools
      ++ lua-tools
      ++ nix-tools;
    home.shellAliases = {
      ed = "rlwrap ed --extended-regexp --prompt=': '";
    };
  };
}
