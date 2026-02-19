###############################################################################
# SCRIPT: paths.zsh
# ROLE: Create directories and symlinks
###############################################################################

install_paths() {
    local script_dir="${0:A:h}"
    source "${script_dir:h}/config/paths.zsh"

    info "Setting up paths..."

    local failed=0

    # Create directories
    for dir in "${DIRECTORIES[@]}"; do
        if [[ -d "$dir" ]]; then
            (( VERBOSE )) && warn "Directory already exists: $dir"
            log_msg "skip" "Directory already exists: $dir"
        else
            if ! run_cmd "Create directory: $dir" "mkdir -p '$dir'"; then
                fail_soft "Failed to create directory: $dir"
                (( failed++ ))
            fi
        fi
    done

    # Create symlinks
    for entry in "${SYMLINKS[@]}"; do
        local parts=("${(@s:|:)entry}")
        local target="$parts[1]"
        local link="$parts[2]"

        if [[ -L "$link" && "$(readlink "$link")" == "$target" ]]; then
            (( VERBOSE )) && warn "Symlink already exists: $link -> $target"
            log_msg "skip" "Symlink already exists: $link -> $target"
        elif [[ -e "$link" ]]; then
            fail_soft "$link already exists and is not a symlink to $target"
            (( failed++ ))
        else
            if ! run_cmd "Create symlink: $link -> $target" "ln -s '$target' '$link'"; then
                fail_soft "Failed to create symlink: $link -> $target"
                (( failed++ ))
            fi
        fi
    done

    if (( failed > 0 )); then
        fail_soft "$failed path(s) failed to set up"
        return 1
    fi

    ok "Paths configured"
    return 0
}
