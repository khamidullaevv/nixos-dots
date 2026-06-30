{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/boot
    ../../modules/networking
    ../../modules/hardware
    ../../modules/services
    ../../modules/desktop
    ../../modules/themes
    ../../modules/development
    ../../modules/gaming
    ../../modules/users
  ];
}