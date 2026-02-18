###############################################################################
# SCRIPT: xcode.zsh
# ROLE: Install Xcode Command Line Tools
###############################################################################

install_xcode() {
    info "Checking for Xcode Command Line Tools..."

    if xcode-select -p &>/dev/null; then
        ok "Xcode CLI Tools already installed"
        return 0
    fi

    info "Installing Xcode Command Line Tools..."
    run_cmd "Install Xcode CLI Tools" "xcode-select --install"

    # xcode-select --install opens a GUI dialog; wait for it to finish
    until xcode-select -p &>/dev/null; do
        sleep 5
    done

    if xcode-select -p &>/dev/null; then
        ok "Xcode CLI Tools installed"
        return 0
    else
        fail_soft "Xcode CLI Tools installation failed"
        return 1
    fi
}
