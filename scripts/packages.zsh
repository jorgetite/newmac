###############################################################################
# SCRIPT: packages.zsh
# ROLE: Install Homebrew formulae and casks
###############################################################################

install_packages() {
    local script_dir="${0:A:h}"
    source "${script_dir:h}/config/packages.zsh"

    info "Installing Homebrew packages..."

    run_cmd "Update Homebrew" "brew update"

    local failed=0

    # Install formulae
    if (( ${#FORMULAE[@]} > 0 )); then
        info "Installing formulae..."
        for formula in "${FORMULAE[@]}"; do
            if brew list --formula "$formula" &>/dev/null; then
                (( VERBOSE )) && warn "$formula already installed"
                log_msg "skip" "Formula $formula already installed"
            else
                if ! run_cmd "Install formula: $formula" "brew install $formula"; then
                    fail_soft "Failed to install formula: $formula"
                    (( failed++ ))
                fi
            fi
        done
    fi

    # Install casks
    if (( ${#CASKS[@]} > 0 )); then
        info "Installing casks..."
        for cask in "${CASKS[@]}"; do
            if brew list --cask "$cask" &>/dev/null; then
                (( VERBOSE )) && warn "$cask already installed"
                log_msg "skip" "Cask $cask already installed"
            else
                if ! run_cmd "Install cask: $cask" "brew install --cask $cask"; then
                    fail_soft "Failed to install cask: $cask"
                    (( failed++ ))
                fi
            fi
        done
    fi

    if (( failed > 0 )); then
        fail_soft "$failed package(s) failed to install"
        return 1
    fi

    ok "All packages installed"
    return 0
}
