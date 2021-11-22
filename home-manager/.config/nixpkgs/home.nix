{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];


  home.packages = with pkgs; [
    autojump
    autocutsel
    #neovim-nightly
    neovim
    wally-cli

    git
    gitAndTools.gh
    nodejs

    fzf
    fd
    httpie
    jq
    gron
    ripgrep
    stow
    telnet
    htop
    bottom
    cloc
    curl

    python39Packages.grip
    python39Packages.pgcli
    python39Packages.awscrt  # needed for awscli2

    python39Packages.tkinter

    vault
    awscli2

    #coursier
    #bloop
    scalafix

    go
    dep
    #docker
    #docker_compose
    #visualvm
    protobuf

    #c-blosc
    #qmk
    #virtualbox

    # must be last
    zsh-syntax-highlighting
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "changeme";
  home.homeDirectory = "/home/changeme";

  home.sessionVariables = {
    EDITOR = "vim";
  };

  #programs.zsh.enableAutosuggestions = true;
  
  programs.alacritty = {
    enable = false;
  };

  programs.git = {
    enable = true;

    includes = [
      { path = "~/.gitconfig-personal"; condition = "gitdir:~/projects/"; }
      { path = "~/.gitconfig-personal"; condition = "gitdir:~/dotfiles/"; }
      { path = "~/.gitconfig-ssc"; condition = "gitdir:~/ssc/"; }
    ];

    extraConfig = {
      color = {
        ui = "auto";
      };
      diff = {
        tool = "meld";
      };
      difftool = {
        prompt = false;
      };
      merge = {
        tool = "meld";
      };
      mergetool = {
        prompt = false;
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.direnv = {
    enable = true;
    #enableNixDirenvIntegration = true;
    nix-direnv.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}

