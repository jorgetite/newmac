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
    wget
    curl
    tree
    jq
    ripgrep
    fzf
    bat
    eza
    zoxide
    tmux
    neovim
    node
    python
    go
)

# Homebrew casks (GUI applications)
typeset -a CASKS=(
    visual-studio-code
    firefox
    iterm2
    rectangle
    raycast
    1password
    docker
    slack
    spotify
    notion
)
