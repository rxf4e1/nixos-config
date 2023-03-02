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
    cargo
    clippy
    cmake
    gcc
    rustc
    rustup
    rustfmt
    rust-analyzer
  ];

  code-tools = with pkgs; [
    pandoc
    tectonic
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
        htop
        lsd
        bat
        fd
        feh
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
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = ["-d 30%"];
      changeDirWidgetCommand = "fd --color=auto --type=d";
      changeDirWidgetOptions = ["--preview 'lsd --tree --color=always -L 4 {}'"];
      defaultCommand = "fd --color=auto";
      fileWidgetCommand = "fd --color=auto --type=f";
      fileWidgetOptions = ["--preview 'head -n 100 {}'"];
    };

    programs.bash = {
      initExtra = ''
        export PATH=$(yarn global bin):$PATH
      '';
    };
  };
}
