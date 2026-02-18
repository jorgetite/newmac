###############################################################################
# SCRIPT: dotfiles.zsh
# ROLE: Clone and install dotfiles
###############################################################################

DOTFILES_REPO="https://github.com/jorgetite/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

install_dotfiles() {
    info "Setting up dotfiles..."

    if [[ -d "$DOTFILES_DIR" ]]; then
        info "Dotfiles directory exists, pulling latest changes..."
        run_cmd "Pull dotfiles" "git -C '$DOTFILES_DIR' pull"
    else
        info "Cloning dotfiles repository..."
        if ! run_cmd "Clone dotfiles" "git clone '$DOTFILES_REPO' '$DOTFILES_DIR'"; then
            fail_soft "Failed to clone dotfiles repository"
            return 1
        fi
    fi

    local installer="$DOTFILES_DIR/install.zsh"

    if [[ ! -f "$installer" ]]; then
        fail_soft "Dotfiles install script not found: $installer"
        return 1
    fi

    run_cmd "Set dotfiles installer permissions" "chmod +x '$installer'"

    info "Running dotfiles installer..."
    if run_cmd "Run dotfiles installer" "'$installer'"; then
        ok "Dotfiles installed"
        return 0
    else
        fail_soft "Dotfiles installer failed"
        return 1
    fi
}
