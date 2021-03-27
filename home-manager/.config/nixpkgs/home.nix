{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    autojump
    tmux
    neovim-nightly

    git
    gitAndTools.gh
    nodejs

    fzf
    httpie
    jq
    gron
    ripgrep
    stow
    telnet
    htop
    cloc

    python38Packages.grip

    vault
    awscli2
    pgcli

    coursier
    bloop
    scalafmt
    sbt
    scala
    ammonite

    # must be last
    zsh-syntax-highlighting
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "changeme";
  home.homeDirectory = "/Users/changeme";

  home.sessionVariables = {
    EDITOR = "vim";
  };

  #programs.zsh.enableAutosuggestions = true;

  programs.git = {
    enable = true;

    includes = [
      { path = "~/.gitconfig-personal"; condition = "gitdir:~/personal/"; }
      { path = "~/.gitconfig-personal"; condition = "gitdir:~/dotfiles/"; }
      { path = "~/.gitconfig-work"; condition = "gitdir:~/projects/"; }
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
    enableNixDirenvIntegration = true;
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
