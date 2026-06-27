{ ... }:

{
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}