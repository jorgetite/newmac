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
    git
    gh
    jq
    tmux
    pass
    mas
)

# Homebrew casks (GUI applications)
typeset -a CASKS=(
    zed
    wezterm
)
