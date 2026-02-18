###############################################################################
# SCRIPT: fonts.zsh
# ROLE: Install fonts via Homebrew casks
###############################################################################

install_fonts() {
    local script_dir="${0:A:h}"
    source "${script_dir:h}/config/fonts.zsh"

    info "Installing fonts..."

    local failed=0

    for font in "${FONT_CASKS[@]}"; do
        if brew list --cask "$font" &>/dev/null; then
            (( VERBOSE )) && warn "$font already installed"
            log_msg "skip" "Font $font already installed"
        else
            if ! run_cmd "Install font: $font" "brew install --cask $font"; then
                fail_soft "Failed to install font: $font"
                (( failed++ ))
            fi
        fi
    done

    if (( failed > 0 )); then
        fail_soft "$failed font(s) failed to install"
        return 1
    fi

    ok "All fonts installed"
    return 0
}
