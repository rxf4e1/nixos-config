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
      kakoune.enable = true;
      micro.enable = false;
      nano.enable = true;
      neovim.enable = true;
    };

    # Terminal
    bash.enable = true;
    foot.enable = true;
    kitty.enable = true;
    starship.enable = true;
    tmux.enable = true;
    zsh.enable = true;

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
      broot.enable = false;
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
