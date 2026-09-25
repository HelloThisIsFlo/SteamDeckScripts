# 🎮 Steam Deck Hub

Entry point for everything Steam Deck: this repo's scripts, the sibling repos, and where the notes live.

## 🗺️ Repos

| Repo | What | Where it lives on the Deck |
|---|---|---|
| **SteamDeckScripts** (this one) | Utility scripts, boot videos, legacy audio setup | Anywhere (run over SSH or locally) |
| [SteamDeck-Pipewire](https://github.com/HelloThisIsFlo/SteamDeck-Pipewire) 🔒 | Current virtual 7.1 surround + per-headphone EQ | `~/.config/pipewire` |
| [Deckpad](https://github.com/HelloThisIsFlo/Deckpad) | Use the Deck as a wireless PC controller | — |

## 📜 This repo

### On the Deck
- `initialize_after_os_update.sh`
  - Re-applies what a SteamOS update wipes
  - zsh as default shell, disable read-only mode, refresh pacman keyring, full upgrade
- `install_pacman_packages.sh`
  - xorg-xinput, figlet, git-delta
- `go_to_sd_card.sh`
  - `cd` into the SD card mount (`source` it, otherwise the `cd` dies with the subshell)
- `find_screenshots.sh`
  - Lists Steam screenshots on the Deck

### From the Mac (`Remote/`)
Assumes an SSH host named `steamdeck`.
- `set_boot_video.sh <video.webm>`
  - Uploads a custom startup video to `~/.steam/root/config/uioverrides/movies/deck_startup.webm`
- `dowload_all_screenshots.sh`
  - Copies all Steam screenshots from the Deck into `Remote/Screenshots`

### Assets
- `BootVideos/`
  - Ready-to-use startup videos
- `VirtualSound/` ⚠️ legacy
  - Earlier HeSuVi 7.1 sink + EasyEffects (systemd user service) approach
  - Superseded by [SteamDeck-Pipewire](https://github.com/HelloThisIsFlo/SteamDeck-Pipewire)

## 🔊 Audio, in one glance
- **SteamDeck-Pipewire** defines a filter-chain sink `Virtual Surround (A)`
  - 7.1 → binaural via HRIR convolvers (`active_hrir.wav`)
  - Headphone correction via AutoEQ convolver (`active_eq.wav`)
- Preset scripts `{game,movie,music}_<headphone>.sh` swap both symlinks and restart PipeWire
  - Game = `gsx+`, Movie = `dh++`, Music = `ooyh0` (`music_alt` = `ooyh1`)
- Presets are launched from Gaming Mode via the Decky **Bash Shortcuts** plugin

## 📚 Notes elsewhere
- **Notion**
  - Steam Deck Setup Notes: general setup log (SSH, Decky, emulation, audio shortcuts)
  - Virtualization Steam Deck Experiment: original 2022 PipeWire HeSuVi experiment
  - HeSuVi (Windows): best HRIR/EQ/bass-boost settings per use case
- **LogSeq** (The Graph)
  - `Steam Deck` page: install steps, Bash Shortcuts config, pavucontrol tweaks
