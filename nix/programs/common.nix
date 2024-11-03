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
    zoxide
    stow
    just
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
    ncdu
  ];

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      stylua
      lua-language-server
      xclip # for neovim clipboard
      nil # lsp for .nix (nvim)
      nixfmt-rfc-style
      cargo # for some rust tools
    ];
  };

  # dotfiles
  # Activation script to run stow using its Nix store path
  home.activation.stow = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.home.homeDirectory}/dotfiles" ]; then
      ${pkgs.git}/bin/git clone https://github.com/xaknick/dotfiles.git ${config.home.homeDirectory}/dotfiles
      echo "Running stow for dotfiles"
      cd ${config.home.homeDirectory}/dotfiles
      ${pkgs.stow}/bin/stow nvim zsh wezterm yazi
    fi
  '';

  # Activation script to install zap during home-manager activation
  home.activation.installZap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.home.homeDirectory}/.local/share/zap" ]; then
      echo "Cloning zap"
      ${pkgs.git}/bin/git clone https://github.com/zap-zsh/zap.git ${config.home.homeDirectory}/.local/share/zap
    else
      echo "Zap is already installed"
    fi
  '';
}
