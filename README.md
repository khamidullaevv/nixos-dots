# 🚀 Sairex NixOS Dots

> A modern, modular and reproducible NixOS configuration built around **Hyprland**, **Home Manager**, and an interactive installer.

---

## ✨ Features

* 🧩 Modular NixOS configuration
* 🏠 Home Manager integration
* 🖥️ Hyprland desktop environment
* 🎨 Material You dynamic theming *(planned)*
* ⚡ Interactive terminal installer
* 📦 Flake-based configuration
* 🔒 Reproducible system builds
* 🧹 Clean repository structure
* 📚 Well documented source code

---

## 📂 Repository Structure

```text
.
├── assets/
├── home/
├── hosts/
├── lib/
├── modules/
│   ├── boot/
│   ├── desktop/
│   ├── development/
│   ├── gaming/
│   ├── hardware/
│   ├── networking/
│   ├── services/
│   └── themes/
├── overlays/
├── pkgs/
├── scripts/
│   └── installer/
├── wallpapers/
├── flake.nix
└── README.md
```

---

## 🚀 Installation

Clone the repository.

```bash
git clone https://github.com/<username>/nixos-dots.git
cd nixos-dots
```

Run the installer.

```bash
bash scripts/installer/install.sh
```

The installer will:

* verify your environment
* collect user preferences
* detect hardware
* generate configuration
* prepare the system
* build the configuration

---

## 🖥️ Technologies

* NixOS
* Nix Flakes
* Home Manager
* Hyprland
* Quickshell
* Fish Shell
* Kitty
* Rofi
* Dunst
* Neovim

---

## 📸 Screenshots

Screenshots will be added after the first stable release.

---

## 🗺️ Roadmap

### Installer

* [x] Installer framework
* [x] Hardware detection
* [x] User configuration
* [ ] Automatic disk setup
* [ ] Automatic configuration generation
* [ ] Interactive installation
* [ ] Error recovery

### Desktop

* [ ] Hyprland configuration
* [ ] Quickshell desktop
* [ ] Dynamic wallpapers
* [ ] Material You colors
* [ ] GTK theme generation
* [ ] Icon theme generation

### Development

* [ ] Neovim
* [ ] Git
* [ ] Development environment
* [ ] Programming language profiles

---

## 🎨 Vision

The goal of this project is to create a beautiful, fast and reproducible Hyprland experience that anyone can install with a single command.

The repository focuses on:

* simplicity
* modularity
* maintainability
* reproducibility
* excellent documentation

---

## 🤝 Contributing

Contributions, ideas and bug reports are welcome.

Feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.
