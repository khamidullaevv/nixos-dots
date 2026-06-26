# 🚀 nixos-dots

> Modern, modular and reproducible NixOS configuration powered by Flakes, Home Manager, Hyprland and Quickshell.

![NixOS](https://img.shields.io/badge/NixOS-26.05-blue?logo=nixos)
![License](https://img.shields.io/badge/License-MIT-green)
![Flakes](https://img.shields.io/badge/Flakes-enabled-blueviolet)

---

## ✨ Features

* ❄️ Nix Flakes
* 🏠 Home Manager
* 🖥️ Hyprland
* ⚡ Quickshell
* 🎨 Catppuccin
* 🧩 Modular configuration
* 🔄 Reproducible system
* 🎮 NVIDIA + CUDA support

---

## 📂 Project Structure

```text
.
├── assets
├── docs
├── flake.nix
├── home
├── hosts
├── modules
├── overlays
├── pkgs
├── scripts
└── wallpapers
```

---

## 🛠️ Installation

Clone the repository:

```bash
git clone https://github.com/<your-username>/nixos-dots.git
cd nixos-dots
```

Build the system:

```bash
sudo nixos-rebuild switch --flake .#loq
```

---

## 📦 Requirements

* NixOS
* Flakes enabled
* Git

---

## 📖 Roadmap

* [x] Repository structure
* [x] Flake
* [ ] Home Manager modules
* [ ] Hyprland configuration
* [ ] Quickshell
* [ ] Themes
* [ ] Documentation
* [ ] GitHub Actions

---

## 📄 License

This project is licensed under the MIT License.
