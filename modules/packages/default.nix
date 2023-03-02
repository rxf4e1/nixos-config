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
    rustc
    # rustup
    rustfmt
    rust-analyzer
  ];

  code-tools = with pkgs; [
    pandoc
    tectonic
    python3
    perl
    shfmt
    alejandra #nixpkgs-fmt
    nodejs
    yarn
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
        nix-prefetch-git
        pcmanfm
        poppler
        zathura
        zettlr
      ]
      ++ code-tools
      ++ rust-env
      ++ inet-tools;
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = ["-d 30%"];
      changeDirWidgetCommand = "fd --color=auto --type=d";
      changeDirWidgetOptions = ["--preview 'exa --tree --color=always -L 4 {}'"];
      defaultCommand = "fd --color=auto";
      fileWidgetCommand = "fd --color=auto --type=f";
      fileWidgetOptions = ["--preview 'head -n 100 {}'"];
    };
    # programs.skim = {
    #   enable = true;
    #   enableBashIntegration = true;
    #   changeDirWidgetCommand = "fd --color=auto --type=d";
    #   changeDirWidgetOptions = ["--preview 'tree -C {} | head -100'"];
    #   defaultOptions = ["--prompt ̣⟫ " "--height 40%"];
    #   defaultCommand = "fd --color=auto";
    #   fileWidgetCommand = "fd --color=auto --type=f";
    #   fileWidgetOptions = ["--preview 'head -n 100 {}'"];
    #   historyWidgetOptions = ["--tac" "--exact"];
    # };

    # programs.lsd = {
    #   enable = true;
    #   enableAliases = true;
    #   settings = {
    #     color.when = "auto";
    #     color.theme = "default";
    #     date = "date";
    #     deference = false;
    #     icons = {
    #       when = "auto";
    #       theme = "fancy";
    #       separator = " ";
    #     };
    #     ignore-globs = [".direnv" ".git"];
    #     indicators = true;
    #     layout = "grid";
    #     recursion = {
    #       enabled = false;
    #       depth = 3;
    #     };
    #     size = "default";
    #     permission = "octal"; # rwx
    #     sorting = {
    #       column = "name";
    #       reverse = false;
    #       dir-grouping = "first";
    #     };
    #     no-symlink = true;
    #     total-size = false;
    #     hyperlink = "auto";
    #     symlink-arrow = "⇒";
    #     header = false;
    #   };
    # };

    programs.bash = {
      initExtra = ''
        export PATH=$(yarn global bin):$PATH
      '';
    };
  };
}
