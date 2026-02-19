###############################################################################
# CONFIG: apps.zsh
# ROLE: Define Mac App Store applications to install
#
# DESCRIPTION:
#   Add or remove items from the array below to customize which apps
#   are installed. Each entry is a pipe-delimited string: "id|name"
#   The id is the numeric App Store ID found in the app's URL.
#   One item per line. Comments are allowed.
#
#   Requires: mas (installed via Homebrew in the packages phase)
#   Requires: signed in to the Mac App Store
###############################################################################

typeset -a MAS_APPS=(
    "1024640650|CotEditor"
)
