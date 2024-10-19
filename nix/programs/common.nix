{
  lib,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    wezterm
    meslo-lgs-nf
    fzf
    ripgrep
    starship
    bat
    eza

    stow
    neofetch
    mc
    yazi
    lazygit
    zip
    unzip
    jq
    cowsay
    file
    which
    tree
    btop
    wget
    curl

    # Nvim
    neovim
    xclip # for neovim clipboard
    # LSP and formatting configuration
    nil # lsp for .nix (nvim)
    lua-language-server
    stylua
    nixfmt-rfc-style
  ];

  # dotfiles
  # Activation script to run stow using its Nix store path
  home.activation.stow = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.home.homeDirectory}/dotfiles" ]; then
      ${pkgs.git}/bin/git clone git@github.com:xaknick/dotfiles.git ${config.home.homeDirectory}/dotfiles
    fi
    echo "Running stow for dotfiles"
    cd ${config.home.homeDirectory}/dotfiles
    ${pkgs.stow}/bin/stow nvim zsh wezterm
  '';

  # Activation script to install zap during home-manager activation
  home.activation.installZap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.home.homeDirectory}/.local/share/zap" ]; then
      echo "Cloning zap"
      ${pkgs.git}/bin/git clone git@github.com:zap-zsh/zap.git ${config.home.homeDirectory}/.local/share/zap
    else
      echo "Zap is already installed"
    fi
  '';
}
