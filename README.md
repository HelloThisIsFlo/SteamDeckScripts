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
- **SteamDeck-Pipewire** defines a filter-chain sink `Virtual Surround (C)`
  - 7.1 → binaural via HRIR convolvers (`active_hrir.wav`)
  - Headphone correction via AutoEQ convolver (`active_eq.wav`)
- One script: `~/.config/pipewire/scripts/surround.sh <mode> <headphones>`, then **Restart Steam**
  - From Gaming Mode: Quick Access Menu → 🎧 **Surround** (our own Decky plugin, source in `SteamDeck-Pipewire/decky-plugin/`)
  - Modes: `game`, `movie`, `music`, `music_alt`; `off` = plain stereo on the speaker
  - Full details in the [SteamDeck-Pipewire README](https://github.com/HelloThisIsFlo/SteamDeck-Pipewire)
- 🍎 AirPods keep jumping to the iPhone? iPhone → Bluetooth → AirPods → Connect to This iPhone → *When Last Connected*

## 📚 Notes elsewhere
- **Notion**
  - Steam Deck Setup Notes: general setup log (SSH, Decky, emulation, audio shortcuts)
  - Virtualization Steam Deck Experiment: original 2022 PipeWire HeSuVi experiment
  - HeSuVi (Windows): best HRIR/EQ/bass-boost settings per use case
- **LogSeq** (The Graph)
  - `Steam Deck` page: install steps, pavucontrol tweaks, Bash Shortcuts config (outdated)

## 🖥️ Hardware
- **Steam Deck OLED** (`Galileo`), **Samsung (SDC)** panel: EDID `VLV 0x3003`, matched by gamescope's `valve.steamdeck.oled.lua`
  - Some SDC panels show colour fringing on text: the reason for the `DefringSamsungOLEDeck.fx` shader (see TODO)

## 🔌 Decky Loader
- **Boot loop fixed (2026-09-25)**: Steam restarted 3-4× at boot because old plugins crashed `steamwebhelper`
  - Fix: moved all 26 old plugins to `~/homebrew/plugins.old` (still there as a fallback), reinstalled only what's needed
- Installed now (2026-09-25, 23 plugins, clean boot):
  - 🎧 Audio: `decky-surround` (ours, from ZIP), MagicPods, Volume Mixer, volume-boost, MusicControl
  - 🎮 Games: ProtonDB Badges, HLTB, SteamGridDB, Wine Cellar, game-settings, Pause Games, Quick Launch, SuggestMe, ControllerTools
  - 📡 Streaming: MoonDeck, Sunshine (its `Error:` lines at boot are encoder probing: harmless)
  - 🧰 Misc: CSS Loader (themes kept), Web Browser, MagicBlack, Notebook, Brightness Bar, AutoFlatpaks, speed-test
- Skipped on purpose: MangoPeel (broken UI, prime boot-loop suspect), Reshadeck (UI crashes), LetMeReShade (per-game ReShade, not a screen fix), Bluetooth (SteamOS reconnects itself), Cloud Save (never configured), Battery Tracker, ScreenshotUploader, Discord Status; Bookmarks / Network Info are gone from the store
- Plugin config lives in `~/homebrew/settings/<plugin>/` (+ `~/homebrew/themes/`, `~/.config/moondeck/`); caches in `~/homebrew/data/`
  - Survives Decky's `uninstall.sh` and moving `plugins/` aside
  - Backup: `~/Backups/SteamDeck/decky-config-2026-09-25.tgz` on the Mac. Restore: `ssh steamdeck 'tar xzf - -C ~' < <tgz>`
- Non-store plugins: Decky ⚙️ → Developer → **Install Plugin from ZIP File** (developer mode is on)
- 🪦 **Bash Shortcuts** is gone: abandoned (last build = unmerged PR [SDH-Stewardship#1](https://github.com/SDH-Stewardship/bash-shortcuts/pull/1)) and its backend crashes on current Decky (`OPENSSL_3.3.0 not found`). Replaced by the Surround plugin

## 📝 TODO
- [ ] Onboard **chezmoi** on the Deck (same dotfiles repo as the Mac)
  - Binary in `~/.local/bin`; scope per machine with `.chezmoiignore` + `{{ if eq .chezmoi.os "linux" }}`
  - Needs GitHub access on the Deck (read-only deploy key or fine-grained token)
  - Manage Decky configs: plugin-written files (`~/homebrew/settings/`, `~/homebrew/themes/`, `~/.config/moondeck/`) as restore-only (`create_`, check how `re-add` behaves)
  - Skip caches (`~/homebrew/data/`) and `~/.config/pipewire` (own repo)
  - Until then: manual tarball in `~/Backups/SteamDeck/` on the Mac (first one: 2026-09-25, before the Decky fix)
- [ ] Install **lazygit** on the Deck, in `~` so it survives SteamOS updates (`/usr` is read-only and wiped)
  - Preferred: install mise in `~/.local/bin`, then `mise use -g lazygit` (same tool as on the Mac)
  - Check that `~/.local/bin` is in `PATH` (it isn't for non-interactive `ssh steamdeck '…'`)
- [ ] Delete `~/homebrew/plugins.old` once the new plugin set has proven itself (plugins reviewed and reinstalled on 2026-09-25)
- [ ] **Defring toggle** in the Surround plugin (replaces Reshadeck, whose UI crashes on current Steam)
  - Reshadeck was just a wrapper around one command: `DISPLAY=:0 xprop -root -f GAMESCOPE_RESHADE_EFFECT 8u -set GAMESCOPE_RESHADE_EFFECT DefringSamsungOLEDeck.fx` (off: set it to `""`)
  - Shader already in `~/.local/share/gamescope/reshade/Shaders/`; copy it into SteamDeck-Pipewire so it's versioned
  - ✅ Works on the Steam UI too. Blind test (2026-09-25, 5 random rounds): 4/5 right, every confident call right; the only miss was an "unsure"
  - Probably resets on reboot → re-apply on plugin load
- [ ] Clean up LetMeReShade leftovers: `~/.local/share/reshade/` (shader packs it downloaded)
- [ ] Frame generation, another day
  - **Decky Framegen** (OptiScaler, FSR3 FG): only for single-player DX12 games with DLSS/FSR already at 40+ fps; patches DLLs per game; ⚠️ anti-cheat bans in online games
  - **Decky LSFG-VK** (Lossless Scaling): needs the paid Steam app; global Vulkan layer; v0.14 (2026-09) breaks HDR and non-Steam games → wait
- [ ] If audio routing acts weird after a `surround.sh` switch: disable **MagicPods** and **volume-boost** first (both touch audio)
- [ ] Update notes that still describe Bash Shortcuts: LogSeq `Steam Deck` page, Notion *Steam Deck Setup Notes* (also lists a wrong config path)
- [ ] Maybe: a generic Bash Shortcuts replacement for the Decky store
