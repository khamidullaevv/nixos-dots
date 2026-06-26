boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

boot.kernelPackages = pkgs.linuxPackages_latest;

boot.kernelModules = [
  "nvidia"
  "nvidia_modeset"
  "nvidia_uvm"
  "nvidia_drm"
];