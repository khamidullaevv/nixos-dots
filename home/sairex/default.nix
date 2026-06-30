{ config, pkgs, inputs, unstable, ... }:

{
  imports = [
    ../../modules/users
  ];

  home = {
    username = "sairex";
    homeDirectory = "/home/sairex";

    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}