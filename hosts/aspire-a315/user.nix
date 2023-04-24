{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [../../modules];

  config.modules = {
    # Browsers
    brave.enable = true;
    qutebrowser.enable = true;

    # Editors
    editor = {
      emacs.enable = false;
      helix.enable = false;
      kakoune.enable = false;
      micro.enable = false;
      nano.enable = true;
      neovim.enable = true;
    };

    # Terminal
    terminal = {
      emu = {
        foot.enable = false;
        kitty.enable = false;
        tmux.enable = true;
        wezterm.enable = true;
      };
      shell = {
        bash.enable = true;
        zsh.enable = false;
      };
      prompt.starship.enable = true;
    };

    # Gui
    desktop = {
      wld = {
        common.enable = true;
        hyprland.enable = false;
        sway.enable = true;
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
