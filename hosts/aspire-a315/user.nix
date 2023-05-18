{
  # config,
  # lib,
  # inputs,
  ...
}: {
  imports = [../../modules];

  config.modules = {
    # Browsers
    brave.enable = true;
    qutebrowser.enable = true;

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
        tmux.enable = true;
        wezterm.enable = false;
      };
      shell = {
        bash.enable = true;
        fish.enable = false;
        ion.enable = true;
        # zsh.enable = true;
      };
      prompt.starship.enable = true;
    };

    # Gui
    desktop = {
      wld = {
        common.enable = true;
        hikari.enable = false;
        hyprland.enable = true;
        sway.enable = false;
        notify.enable = true;
      };
      gtk.enable = true;
      # qt6.enable = true; # :TODO:
      widgets.enable = false;
    };

    # CLI
    cli = {
      broot.enable = true;
      direnv.enable = true;
      fzf.enable = true;
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
