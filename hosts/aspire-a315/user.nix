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
        hyprland.enable = true;
        notify.enable = true;
      };
    };

    # CLI
    cli = {
      broot.enable = true;
      direnv.enable = true;
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
