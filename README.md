# New Mac Setup

Automates setting up a fresh macOS system. Installs software, configures system settings, and sets up your development environment.

The script is **idempotent** -- safe to run multiple times.

## Quick Start

```sh
chmod +x install.zsh
./install.zsh
```

You'll be prompted to choose between a **default install** (all components) or a **custom install** (select individually), and whether to enable verbose output.

## Components

| Order | Component | Description |
|-------|-----------|-------------|
| 1 | **Xcode CLI Tools** | Installs Apple's command line developer tools |
| 2 | **Homebrew** | Installs the Homebrew package manager |
| 3 | **Packages** | Installs Homebrew formulae (CLI tools) and casks (GUI apps) |
| 4 | **System Settings** | Applies a curated set of macOS defaults (Dock, Finder, keyboard, etc.) |
| 5 | **Fonts** | Installs fonts via Homebrew casks |
| 6 | **Dotfiles** | Clones and runs the [dotfiles](https://github.com/jorgetite/.dotfiles.git) installer |

## Customization

The `config/` directory holds editable lists that control what gets installed. Modify these files to match your preferences.

### Packages (`config/packages.zsh`)

```zsh
typeset -a FORMULAE=(
    git
    gh
    neovim
    # add more formulae here
)

typeset -a CASKS=(
    visual-studio-code
    firefox
    # add more casks here
)
```

### Fonts (`config/fonts.zsh`)

```zsh
typeset -a FONT_CASKS=(
    font-fira-code
    font-jetbrains-mono
    # add more font casks here
)
```

### System Defaults (`config/defaults.zsh`)

Pipe-delimited entries: `"domain|key|type|value"`

```zsh
typeset -a DEFAULTS=(
    "NSGlobalDomain|AppleInterfaceStyle|string|Dark"
    "com.apple.dock|autohide|bool|true"
    "com.apple.finder|AppleShowAllFiles|bool|true"
    # add more defaults here
)
```

Supported types: `string`, `int`, `float`, `bool`. Use `defaults.json` as a reference for discovering keys and domains.

## Project Structure

```
newmac/
├── install.zsh           # Main entry point / orchestrator
├── config/
│   ├── packages.zsh      # Homebrew formulae and casks
│   ├── fonts.zsh         # Font casks
│   └── defaults.zsh      # Curated macOS system defaults
├── scripts/
│   ├── helpers.zsh       # Shared output, logging, and utility functions
│   ├── xcode.zsh         # Xcode CLI Tools installer
│   ├── homebrew.zsh      # Homebrew installer
│   ├── packages.zsh      # Homebrew packages installer
│   ├── system.zsh        # macOS defaults configurator
│   ├── fonts.zsh         # Fonts installer
│   └── dotfiles.zsh      # Dotfiles cloner/installer
└── defaults.json         # Full macOS defaults dump (reference only)
```

## Logging

All actions are recorded to `install_log.txt` (git-ignored). When verbose mode is enabled, command output is also printed to the terminal.

## Prerequisites

- macOS
- Internet connection
