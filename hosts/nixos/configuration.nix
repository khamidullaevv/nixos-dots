{ config, pkgs, inputs, unstable, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/boot
    ../../modules/networking
    ../../modules/nix

    ../../modules/users

    ../../modules/services

    ../../modules/hardware

    ../../modules/security

    ../../modules/system
  ];

  networking.hostName = "nixos";

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";
}