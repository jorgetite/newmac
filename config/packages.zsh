###############################################################################
# CONFIG: packages.zsh
# ROLE: Define Homebrew formulae and casks to install
#
# DESCRIPTION:
#   Add or remove items from the arrays below to customize which packages
#   are installed. One item per line. Comments are allowed.
###############################################################################

# Homebrew formulae (CLI tools)
typeset -a FORMULAE=(
    ansible
    btop
    cronboard
    dust
    dysk
    gemini-cli
    git
    gh
    jq
    mas
    node
    pass
    pgcli
    pyenv
    rustup
    sd
    superfile
    tealdeer
    tmux
)

# Homebrew casks (GUI applications)
typeset -a CASKS=(
    appcleaner
    claude
    claude-code
    handy
    wezterm
    zed
)
