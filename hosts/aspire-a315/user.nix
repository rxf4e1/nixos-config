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
    qutebrowser.enable = false;

    # Editors
    editor = {
      emacs.enable = false;
      kakoune.enable = true;
      micro.enable = false;
      nano.enable = true;
      neovim.enable = false;
    };

    # Terminal
    bash.enable = true;
    foot.enable = true;
    kitty.enable = false;
    tmux.enable = true;

    # Gui
    desktop = {
      wland = {
        newm.enable = true;
        hyprland.enable = false;
        labwc.enable = false;
        notify.enable = true;
      };
      gtk.enable = true;
      # qt6.enable = true; # :TODO:
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
