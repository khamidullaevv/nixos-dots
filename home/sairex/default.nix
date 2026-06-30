{ config, pkgs, ... }:

{
  home = {
    username = "sairex";
    homeDirectory = "/home/sairex";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}