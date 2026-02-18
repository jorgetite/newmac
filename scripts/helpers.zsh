# --- Output Helpers ---
typeset -r BLUE='\033[0;34m'
typeset -r GREEN='\033[0;32m'
typeset -r YELLOW='\033[0;33m'
typeset -r RED='\033[0;31m'
typeset -r BOLD='\033[1m'
typeset -r RESET='\033[0m'

info()  { print -P "${BLUE}[info]${RESET}  $1" }
ok()    { print -P "${GREEN}[ok]${RESET}    $1" }
warn()  { print -P "${YELLOW}[skip]${RESET}  $1" }
fail()  { print -P "${RED}[fail]${RESET}  $1"; exit 1 }

# Function for simple Y/N prompts
confirm_action() {
    # -k1: read only 1 character
    # -r: raw mode (don't treat backslashes as escape characters)
    # -p: prompt the user
    echo -n "$1 (y/n): "
    read -k 1 -r
    echo "" # Move to a new line after the key press
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0 # Success/Yes
    else
        return 1 # Failure/No
    fi
}

# --- Non-fatal failure ---
fail_soft() { print -P "${RED}[fail]${RESET}  $1" }

# --- Logging ---
VERBOSE=${VERBOSE:-0}
LOG_FILE="${0:A:h:h}/install_log.txt"

log_init() {
    print "=== Installation Log: $(date '+%Y-%m-%d %H:%M:%S') ===" > "$LOG_FILE"
}

log_msg() {
    local level="$1" msg="$2"
    print "[$(date '+%H:%M:%S')] [$level] $msg" >> "$LOG_FILE"
}

# Run a command with logging and optional verbose output
# Usage: run_cmd "description" "command to run"
# Returns the command's exit code
run_cmd() {
    local desc="$1" cmd="$2"
    log_msg "run" "$desc: $cmd"

    if (( VERBOSE )); then
        info "$desc"
        eval "$cmd" 2>&1 | tee -a "$LOG_FILE"
    else
        eval "$cmd" >> "$LOG_FILE" 2>&1
    fi

    local rc=${pipestatus[1]:-$?}
    if (( rc == 0 )); then
        log_msg "ok" "$desc"
    else
        log_msg "fail" "$desc (exit $rc)"
    fi
    return $rc
}
