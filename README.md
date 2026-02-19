# New Mac Setup

Automates setting up a fresh macOS system. Installs software, configures system settings, and sets up your development environment.

The script is **idempotent** — safe to run multiple times.

## Prerequisites

- macOS
- Internet connection
- Signed in to the Mac App Store
- `/Volumes/Vault` mounted (for the Secrets component)

## Quick Start

```sh
chmod +x install.zsh
./install.zsh
```

You'll be prompted to choose between a **default install** (all components) or a **custom install** (select individually), and whether to enable verbose output.

## Components

Components run in this order:

| # | Component | Description |
|---|-----------|-------------|
| 1 | **Xcode CLI Tools** | Apple's command line developer tools |
| 2 | **Homebrew** | Homebrew package manager |
| 3 | **macOS Apps** | Mac App Store apps via `mas` |
| 4 | **Packages** | Homebrew formulae and casks |
| 5 | **Fonts** | Fonts via Homebrew casks |
| 6 | **Dotfiles** | Clones and runs the [dotfiles](https://github.com/jorgetite/.dotfiles.git) installer |
| 7 | **Paths** | Creates directories and symlinks |
| 8 | **Secrets** | Copies SSH keys from `/Volumes/Vault` and activates the SSH agent |
| 9 | **System Settings** | Applies curated macOS defaults |

---

## What Gets Installed

### macOS Apps (`config/apps.zsh`)

Installed via `mas`. Requires being signed in to the App Store.

| App | App Store ID |
|-----|-------------|
| CotEditor | 1024640650 |
| Magnet | 441258766 |
| Photomator – Photo Editor | 1444636541 |
| SiteSucker | 442168834 |
| Tailscale | 1475387142 |
| WhatsApp Messenger | 310633997 |

### Homebrew Formulae (`config/packages.zsh`)

| Package | Description |
|---------|-------------|
| ansible | Automation and configuration management |
| btop | Resource monitor |
| cronboard | Cron job manager |
| dust | Disk usage tool (`du` alternative) |
| dysk | Disk info tool |
| gemini-cli | Google Gemini CLI |
| git | Version control |
| gh | GitHub CLI |
| jq | JSON processor |
| mas | Mac App Store CLI |
| node | Node.js runtime |
| pass | Password manager |
| pgcli | PostgreSQL CLI with autocomplete |
| pyenv | Python version manager |
| rustup | Rust toolchain installer |
| sd | Find-and-replace CLI (`sed` alternative) |
| superfile | Terminal file manager |
| tealdeer | Fast `tldr` pages client |
| tmux | Terminal multiplexer |

### Homebrew Casks (`config/packages.zsh`)

| Cask | Description |
|------|-------------|
| appcleaner | App uninstaller |
| claude | Claude for Desktop |
| claude-code | Claude Code |
| handy | Utility app |
| wezterm | GPU-accelerated terminal |
| zed | Code editor |

### Fonts (`config/fonts.zsh`)

Installed via Homebrew casks.

- Fira Code + Nerd Font variant
- JetBrains Mono + Nerd Font variant
- 0xProto + Nerd Font variant
- Source Code Pro
- Reddit Mono
- Sora
- Teko

### Paths (`config/paths.zsh`)

**Directories created:**

| Path |
|------|
| `~/Developer` |

**Symlinks created:**

| Link | Target |
|------|--------|
| `~/Developer/src` | `/Volumes/Axis/src` |

### Secrets

Copied from `/Volumes/Vault` (must be mounted):

| Item | Destination |
|------|-------------|
| `.ssh/` (keys and config) | `~/.ssh/` |

After copying, the SSH key `~/.ssh/id_ed25519` is added to the macOS keychain via `ssh-add --apple-use-keychain`.

### System Settings (`config/defaults.zsh`)

**General**

| Setting | Value |
|---------|-------|
| Appearance | Dark (fixed, no auto-switch) |
| Clock format | 24-hour |
| Show all file extensions | On |
| Alert sound | Funk |
| Sidebar icon size | Large |

**Keyboard**

| Setting | Value |
|---------|-------|
| Full keyboard access | All controls |
| Auto-capitalization | On |
| Auto period substitution | On |

**Trackpad**

| Setting | Value |
|---------|-------|
| Tap to click | On |
| Tracking speed | 1.0 |
| Three-finger drag | On |
| Three-finger swipe gestures | Off (freed for drag) |

**Dock**

| Setting | Value |
|---------|-------|
| Position | Left |
| Icon size | 48 px |
| Minimize to app icon | On |
| App Exposé gesture | On |
| Mission Control gesture | On |

**Finder**

| Setting | Value |
|---------|-------|
| Show hard drives on desktop | On |
| Show mounted servers on desktop | On |
| Sort folders first | On (windows and desktop) |
| Default view | Icon view |
| New window opens | Computer root |
| iCloud Drive (Desktop & Documents) | On |
| Auto-remove old Trash items | On |
| Show recent tags | Off |
| Show preview pane | Off |

**Menu Bar**

| Setting | Value |
|---------|-------|
| Clock AM/PM indicator | Hidden |

**Window Manager**

| Setting | Value |
|---------|-------|
| Tiled window margins | Off |
| Click desktop to hide windows | On |
| App window grouping | On |
| Hide widgets | Off |

---

## Customization

All lists live in `config/`. Edit them to add or remove items before running.

| File | Controls |
|------|----------|
| `config/apps.zsh` | Mac App Store apps (`"id\|name"` per entry) |
| `config/packages.zsh` | Homebrew formulae and casks |
| `config/fonts.zsh` | Font casks |
| `config/paths.zsh` | Directories and symlinks |
| `config/defaults.zsh` | macOS defaults (`"domain\|key\|type\|value"` per entry) |

---

## Project Structure

```
newmac/
├── install.zsh           # Main entry point / orchestrator
├── config/
│   ├── apps.zsh          # Mac App Store app list
│   ├── packages.zsh      # Homebrew formulae and casks
│   ├── fonts.zsh         # Font casks
│   ├── paths.zsh         # Directories and symlinks
│   └── defaults.zsh      # Curated macOS system defaults
├── scripts/
│   ├── helpers.zsh       # Shared output, logging, and utility functions
│   ├── xcode.zsh         # Xcode CLI Tools installer
│   ├── homebrew.zsh      # Homebrew installer
│   ├── apps.zsh          # Mac App Store installer
│   ├── packages.zsh      # Homebrew packages installer
│   ├── fonts.zsh         # Fonts installer
│   ├── dotfiles.zsh      # Dotfiles cloner/installer
│   ├── paths.zsh         # Paths and symlinks configurator
│   ├── secrets.zsh       # Secrets installer
│   └── system.zsh        # macOS defaults configurator
└── defaults.json         # Full macOS defaults dump (reference only)
```

## Logging

All actions are recorded to `install_log.txt` (git-ignored). When verbose mode is enabled, command output is also printed to the terminal.
