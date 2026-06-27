{ pkgs, ... }:

{
  home.username = "sairex";
  home.homeDirectory = "/home/sairex";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}