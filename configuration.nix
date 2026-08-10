{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";               
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";      
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
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

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Classic";
      };
    };
  };

  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;
  services.gvfs.enable = true;          
  services.tumbler.enable = true;      
  services.upower.enable = true;        


  users.users."sairex" = {
    isNormalUser = true;
    description = "Sairex";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget 
    git 
    python3 
    nodejs_22 
    unzip 
    fastfetch 
    htop
    brightnessctl
    playerctl
    cava
    btop
    nautilus
    firefox 
    telegram-desktop 
    spotify 
    obsidian 
    vscodium 
    neovim
    kitty                     
    waybar                  
    rofi             
    swww                      
    mpvpaper
    mpv
    dunst                     
    wlogout                   
    hyprlock                 
    hypridle                
    matugen
    polkit_gnome              
    yazi                     
    xfce.thunar               
    loupe                     
    mpv                       
    grim                      
    slurp                     
    swappy                    
    libnotify
    wl-clipboard              
    cliphist                  
    pavucontrol               
    lsd                       
    bibata-cursors            
    papirus-icon-theme        
    catppuccin-gtk            
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
  ];

  programs.firefox.enable = true;

  system.stateVersion = "26.05";
}
