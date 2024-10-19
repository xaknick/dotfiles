{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    gcc
    gnumake
    zsh
  ];

  # Configure ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
