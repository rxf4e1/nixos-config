{ ... }: {
  imports = [../../modules];

  config.modules = {
    # Browsers
    brave.enable = true;
    firefox.enable = true;
    nyxt.enable = false;
    qutebrowser.enable = false;

    # Editors
    editor = {
      emacs.enable = true;
      helix.enable = true;
      kakoune.enable = false;
      micro.enable = false;
      nano.enable = true;
      neovim.enable = false;
    };

    # Terminal
    terminal = {
      emu = {
        foot.enable = true;
        kitty.enable = false;
        tmux.enable = false;
        wezterm.enable = false;
      };
      shell = {
        bash.enable = true;
        fish.enable = false;
        ion.enable = false;
        nu.enable = false;
        zsh.enable = true;
      };
      prompt.starship.enable = true;
    };

    # Gui
    desktop = {
      wld = {
        common.enable = true;
        # cagereak.enable = false;
        hyprland.enable = true;
        river.enable = false;
        sway.enable = false;
        notify.enable = true;
      };
      gtk.enable = true;
      qt.enable = false;
      widgets.enable = false;
    };

    # CLI
    cli = {
      broot.enable = false;
      direnv.enable = true;
      fzf.enable = false;
      ipfs.enable = false;
      git.enable = true;
      gpg.enable = true;
      lsd.enable = true;
      xdg.enable = true;
    };

    # Security
    secret = {
      keepassxc.enable = true;
      pass.enable = false;
    };

    # System
    packages.enable = true;
  };
}
