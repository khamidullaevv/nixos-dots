{ ... }:

{
  users.users.sairex = {
    isNormalUser = true;
    description = "Sairex";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}