###############################################################################
# SCRIPT: homebrew.zsh
# ROLE: Install Homebrew package manager
###############################################################################

install_homebrew() {
    info "Checking for Homebrew..."

    if command -v brew &>/dev/null; then
        ok "Homebrew already installed"
        return 0
    fi

    info "Installing Homebrew..."
    run_cmd "Install Homebrew" \
        '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

    # Ensure brew is on PATH (Apple Silicon puts it in /opt/homebrew)
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    if command -v brew &>/dev/null; then
        ok "Homebrew installed"
        return 0
    else
        fail_soft "Homebrew installation failed"
        return 1
    fi
}
