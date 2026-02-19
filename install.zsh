#!/usr/bin/env zsh
###############################################################################
# SCRIPT: install.zsh
# ROLE: Set up fresh macOS system
#
# DESCRIPTION:
#   Install required software, utilities and configurations.
#   This script is idempotent, meaning it can be run multiple times without
#   causing any issues.
#
# DEPENDENCIES (Core):
#   - Internet connection
#   - Sign-In into App Store
#
# USAGE:
#   ./install.zsh
###############################################################################

# Resolve the directory this script lives in
SCRIPT_DIR="${0:A:h}"

# --- Load helpers ---
source "$SCRIPT_DIR/scripts/helpers.zsh"

# --- Load installation functions ---
source "$SCRIPT_DIR/scripts/xcode.zsh"
source "$SCRIPT_DIR/scripts/homebrew.zsh"
source "$SCRIPT_DIR/scripts/apps.zsh"
source "$SCRIPT_DIR/scripts/packages.zsh"
source "$SCRIPT_DIR/scripts/fonts.zsh"
source "$SCRIPT_DIR/scripts/dotfiles.zsh"
source "$SCRIPT_DIR/scripts/paths.zsh"
source "$SCRIPT_DIR/scripts/secrets.zsh"
source "$SCRIPT_DIR/scripts/system.zsh"

# --- Component registry ---
typeset -a COMPONENTS=(xcode homebrew apps packages fonts dotfiles paths secrets system)

typeset -A LABELS=(
    [xcode]="Xcode CLI Tools"
    [homebrew]="Homebrew"
    [packages]="Homebrew Packages"
    [apps]="MacOS Apps"
    [fonts]="Fonts"
    [dotfiles]="Dotfiles"
    [paths]="Paths"
    [secrets]="Secrets"
    [system]="System Settings"
)

typeset -A INSTALLERS=(
    [xcode]=install_xcode
    [homebrew]=install_homebrew
    [packages]=install_packages
    [apps]=install_apps
    [fonts]=install_fonts
    [dotfiles]=install_dotfiles
    [paths]=install_paths
    [secrets]=install_secrets
    [system]=install_system
)

# Track which components are selected and their results
typeset -A SELECTED RESULTS

###############################################################################
# Welcome
###############################################################################
print ""
print "${BOLD}  New Mac Setup${RESET}"
print "  ─────────────────────────────────────────────"
print "  This script installs software, configures"
print "  system settings, and sets up your environment."
print ""
print "  Components:"
for comp in "${COMPONENTS[@]}"; do
    print "    - ${LABELS[$comp]}"
done
print ""
echo -n "  Press any key to continue..."
read -k 1 -s
print "\n"

###############################################################################
# Installation mode
###############################################################################
print "  Select installation mode:"
print "    ${BOLD}1${RESET}) Default install (all components)"
print "    ${BOLD}2${RESET}) Custom install (choose components)"
print ""
echo -n "  Choice [1/2]: "
read -k 1 -r mode
print "\n"

if [[ "$mode" == "2" ]]; then
    for comp in "${COMPONENTS[@]}"; do
        if confirm_action "  Install ${LABELS[$comp]}?"; then
            SELECTED[$comp]=1
        else
            SELECTED[$comp]=0
        fi
    done
else
    for comp in "${COMPONENTS[@]}"; do
        SELECTED[$comp]=1
    done
fi

# Verbose toggle
if confirm_action "  Enable verbose output?"; then
    VERBOSE=1
else
    VERBOSE=0
fi

print ""

###############################################################################
# Installation
###############################################################################
log_init
log_msg "info" "Installation started — mode=${mode:-1} verbose=$VERBOSE"

local succeeded=0 failed=0 skipped=0

for comp in "${COMPONENTS[@]}"; do
    if (( ! SELECTED[$comp] )); then
        RESULTS[$comp]="skipped"
        (( skipped++ ))
        log_msg "skip" "${LABELS[$comp]}"
        continue
    fi

    print "─────────────────────────────────────────────"
    info "Installing ${LABELS[$comp]}..."
    log_msg "info" "Starting: ${LABELS[$comp]}"

    if ${INSTALLERS[$comp]}; then
        RESULTS[$comp]="ok"
        (( succeeded++ ))
    else
        RESULTS[$comp]="fail"
        (( failed++ ))
    fi

    print ""
done

###############################################################################
# Summary
###############################################################################
print "═════════════════════════════════════════════"
print "${BOLD}  Installation Summary${RESET}"
print "─────────────────────────────────────────────"

for comp in "${COMPONENTS[@]}"; do
    local label="${LABELS[$comp]}"
    local status="${RESULTS[$comp]}"
    case "$status" in
        ok)      print "  ${GREEN}✓${RESET}  $label" ;;
        fail)    print "  ${RED}✗${RESET}  $label" ;;
        skipped) print "  ${YELLOW}–${RESET}  $label" ;;
    esac
done

print "─────────────────────────────────────────────"
print "  ${GREEN}Succeeded:${RESET} $succeeded  ${RED}Failed:${RESET} $failed  ${YELLOW}Skipped:${RESET} $skipped"
print "  Log file: $LOG_FILE"
print "═════════════════════════════════════════════"
print ""
