{ config, lib, ... }:

let
  username = config.sairex.user.name;
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = username;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}