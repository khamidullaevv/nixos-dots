# Sairex

A modern, modular NixOS configuration built around Hyprland.

Sairex provides a clean installation experience, a modular configuration layout, and an automated installer designed to work on different hardware with minimal manual setup.

---

## Features

- Modular NixOS configuration
- Home Manager integration
- Hyprland desktop
- Automatic hardware detection
- Interactive installer
- Flake-based configuration
- Easy customization
- Material You support *(coming soon)*

---

## Project Structure

```text
.
├── assets/
├── home/
├── hosts/
├── modules/
├── overlays/
├── pkgs/
├── scripts/
│   └── installer/
├── wallpapers/
├── flake.nix
└── README.md
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/<username>/sairex.git
cd sairex
```

Run the installer:

```bash
bash scripts/installer/install.sh
```

The installer will:

- verify your environment
- detect your hardware
- generate `configuration.nix`
- generate `hardware-configuration.nix`
- generate your Home Manager configuration

---

## Requirements

- NixOS
- Flakes enabled
- Git
- Internet connection

---

## Configuration

Generated files are placed inside the repository.

```
hosts/<hostname>/
├── configuration.nix
└── hardware-configuration.nix

home/<username>/
└── default.nix
```

Most system configuration lives in `modules/`, making customization straightforward.

---

## Roadmap

### v0.1

- Interactive installer
- Hardware detection
- Configuration generator
- Home Manager generator

### v0.2

- Material You theming
- Wallpaper color extraction
- Waybar integration
- GTK theme generation
- Qt theme generation

### v0.3

- Additional desktop modules
- Installer improvements
- More customization options

---

## Contributing

Contributions, bug reports, and feature suggestions are welcome.

---

## License

MIT License.