###############################################################################
# SCRIPT: apps.zsh
# ROLE: Install macOS applications from the App Store
#
# DEPENDENCIES:
# - brew, mas
#
# This script installs macOS applications from the App Store using the mas
# command-line tool: mas install <app-id>
###############################################################################

install_apps() {
    local script_dir="${0:A:h}"
    source "${script_dir:h}/config/apps.zsh"

    info "Installing Mac App Store apps..."

    if ! command -v mas &>/dev/null; then
        fail_soft "mas is not installed — run the Packages component first"
        return 1
    fi

    if ! mas account &>/dev/null; then
        fail_soft "Not signed in to the Mac App Store — sign in and re-run"
        return 1
    fi

    local failed=0

    for entry in "${MAS_APPS[@]}"; do
        local parts=("${(@s:|:)entry}")
        local app_id="$parts[1]"
        local app_name="$parts[2]"

        if mas list | grep -q "^$app_id "; then
            (( VERBOSE )) && warn "$app_name already installed"
            log_msg "skip" "$app_name ($app_id) already installed"
        else
            if ! run_cmd "Install $app_name" "mas install $app_id"; then
                fail_soft "Failed to install $app_name ($app_id)"
                (( failed++ ))
            fi
        fi
    done

    if (( failed > 0 )); then
        fail_soft "$failed app(s) failed to install"
        return 1
    fi

    ok "All App Store apps installed"
    return 0
}
