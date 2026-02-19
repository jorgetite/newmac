###############################################################################
# CONFIG: paths.zsh
# ROLE: Define directories to create and symlinks to set up
#
# DESCRIPTION:
#   DIRECTORIES: one path per line. Created with mkdir -p (idempotent).
#   SYMLINKS: pipe-delimited "target|link_path". Skipped if link already
#   points to the correct target. ~ is expanded at runtime.
###############################################################################

# Directories to create
typeset -a DIRECTORIES=(
    "$HOME/Developer"
)

# Symlinks to create: "target|link_path"
typeset -a SYMLINKS=(
    "/Volumes/Axis/src|$HOME/Developer/src"
)
