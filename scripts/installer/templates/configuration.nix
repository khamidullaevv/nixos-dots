{ config, pkgs, ... }:

{
  networking.hostName = "__HOSTNAME__";

  time.timeZone = "__TIMEZONE__";

  i18n.defaultLocale = "__LOCALE__";

  users.users.__USERNAME__ = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];

    shell = pkgs.__SHELL__;
  };

  system.stateVersion = "26.05";
}