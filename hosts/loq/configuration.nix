{ ... }:


{
    
imports = [
  ./hardware-configuration.nix

  ../../modules/boot
  ../../modules/networking
  ../../modules/users
];
}