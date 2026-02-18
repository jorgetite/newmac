###############################################################################
# SCRIPT: system.zsh
# ROLE: Apply curated macOS system defaults
###############################################################################

install_system() {
    local script_dir="${0:A:h}"
    source "${script_dir:h}/config/defaults.zsh"

    info "Applying system settings..."

    local failed=0

    for entry in "${DEFAULTS[@]}"; do
        local parts=("${(@s:|:)entry}")
        local domain="$parts[1]"
        local key="$parts[2]"
        local type="$parts[3]"
        local value="$parts[4]"

        if ! run_cmd "Set $domain $key=$value" \
            "defaults write '$domain' '$key' -$type '$value'"; then
            fail_soft "Failed to set $domain $key"
            (( failed++ ))
        fi
    done

    # Restart affected services to apply changes
    info "Restarting affected services..."
    run_cmd "Restart Dock" "killall Dock" || true
    run_cmd "Restart Finder" "killall Finder" || true
    run_cmd "Restart SystemUIServer" "killall SystemUIServer" || true

    if (( failed > 0 )); then
        fail_soft "$failed setting(s) failed to apply"
        return 1
    fi

    ok "System settings applied"
    return 0
}
