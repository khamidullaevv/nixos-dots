# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ============================================================
  # BOOTLOADER & KERNEL
  # ============================================================

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;


  # ============================================================
  # NETWORKING & LOCALE
  # ============================================================

  networking.hostName = "lenovo-loq";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };


  # ============================================================
  # GRAPHICS & NVIDIA
  # Lenovo LOQ 15IAX9
  # Intel i5-12450HX + RTX 3050 6GB
  # ============================================================

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };


  # ============================================================
  # AUDIO & PERIPHERALS
  # ============================================================

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  services.printing.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;

    jack.enable = true;
  };


  # ============================================================
  # SDDM
  # ============================================================

  services.displayManager.sddm = {
    enable = true;

    # Wayland greeter
    wayland.enable = true;

    # Catppuccin Mocha + Mauve
    theme = "catppuccin-mocha-mauve";
  };


  # ============================================================
  # DESKTOP ENVIRONMENTS
  # ============================================================

  # KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  # ============================================================
  # XDG PORTALS
  # ============================================================

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # ============================================================
  # SYSTEM SETTINGS
  # ============================================================

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;


  # ============================================================
  # USER
  # ============================================================

  users.users.yusufbek = {
    isNormalUser = true;

    description = "Yusufbek";

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "audio"
    ];

    shell = pkgs.fish;
  };

  programs.fish.enable = true;


  # ============================================================
  # SYSTEM PACKAGES
  # ============================================================

  environment.systemPackages = with pkgs; [

    # ----------------------------------------------------------
    # SDDM / THEME
    # ----------------------------------------------------------

    catppuccin-sddm

    # Qt dependencies for Catppuccin SDDM
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects

    # GTK theme
    catppuccin-gtk

    # Icons
    papirus-icon-theme

    # Image viewer
    loupe


    # ----------------------------------------------------------
    # HYPRLAND
    # ----------------------------------------------------------

    waybar
    rofi
    dunst
    wlogout
    hyprpaper
    hyprlock
    hypridle
    cava
    kitty
    foot

    grim
    slurp
    wl-clipboard

    brightnessctl
    pavucontrol


    # ----------------------------------------------------------
    # DEVELOPMENT
    # ----------------------------------------------------------

    # Rust
    rustup
    cargo
    rustc

    # C/C++
    gcc

    # Python
    python3
    poetry
    pipenv

    # Node.js
    nodejs_22
    pnpm
    yarn

    # Containers
    docker-compose

    # Databases
    postgresql
    redis


    # ----------------------------------------------------------
    # EDITORS & APPLICATIONS
    # ----------------------------------------------------------

    vscodium

    jetbrains.pycharm

    obsidian

    firefox

    telegram-desktop

    spotify-player


    # ----------------------------------------------------------
    # CLI UTILITIES
    # ----------------------------------------------------------

    git
    gh

    curl
    wget

    fastfetch

    htop
    btop

    unzip

    ripgrep
    fd

    bat
    eza
  ];


  # ============================================================
  # FONTS
  # ============================================================

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code

    roboto
    noto-fonts-color-emoji
  ];


  # ============================================================
  # NIX
  # ============================================================

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];


  # ============================================================
  # SYSTEM VERSION
  # ============================================================

  system.stateVersion = "26.05";
}
