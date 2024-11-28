{
  lib,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [ 
    jetbrains.jdk
    jetbrains.rider
  ];
}
