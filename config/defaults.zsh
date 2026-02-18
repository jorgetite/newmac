###############################################################################
# CONFIG: defaults.zsh
# ROLE: Define curated macOS system defaults to apply
#
# DESCRIPTION:
#   Each entry is a pipe-delimited string: "domain|key|type|value"
#   Supported types: string, int, float, bool
#
#   Add, remove, or modify entries to customize system settings.
#   Reference: defaults.json contains a full dump for discovering keys.
###############################################################################

typeset -a DEFAULTS=(
    # --- Global / General ---
    "NSGlobalDomain|AppleInterfaceStyle|string|Dark"
    "NSGlobalDomain|AppleICUForce24HourTime|bool|true"
    "NSGlobalDomain|AppleShowAllExtensions|bool|true"
    "NSGlobalDomain|AppleMiniaturizeOnDoubleClick|bool|false"
    "NSGlobalDomain|NSTableViewDefaultSizeMode|int|3"

    # --- Keyboard ---
    "NSGlobalDomain|KeyRepeat|int|2"
    "NSGlobalDomain|InitialKeyRepeat|int|15"
    "NSGlobalDomain|AppleKeyboardUIMode|int|2"
    "NSGlobalDomain|NSAutomaticCapitalizationEnabled|bool|false"
    "NSGlobalDomain|NSAutomaticPeriodSubstitutionEnabled|bool|false"

    # --- Trackpad ---
    "NSGlobalDomain|com.apple.trackpad.scaling|float|1.0"
    "NSGlobalDomain|com.apple.trackpad.forceClick|bool|true"
    "com.apple.AppleMultitouchTrackpad|Clicking|bool|true"
    "com.apple.AppleMultitouchTrackpad|TrackpadThreeFingerDrag|bool|true"
    "com.apple.AppleMultitouchTrackpad|TrackpadRightClick|bool|true"

    # --- Dock ---
    "com.apple.dock|tilesize|int|48"
    "com.apple.dock|orientation|string|bottom"
    "com.apple.dock|autohide|bool|true"
    "com.apple.dock|minimize-to-application|bool|true"
    "com.apple.dock|show-recents|bool|false"
    "com.apple.dock|launchanim|bool|false"

    # --- Finder ---
    "com.apple.finder|AppleShowAllFiles|bool|true"
    "com.apple.finder|ShowPathbar|bool|true"
    "com.apple.finder|ShowStatusBar|bool|true"
    "com.apple.finder|_FXSortFoldersFirst|bool|true"
    "com.apple.finder|FXDefaultSearchScope|string|SCcf"
    "com.apple.finder|FXEnableExtensionChangeWarning|bool|false"

    # --- Screen Capture ---
    "com.apple.screencapture|type|string|png"
    "com.apple.screencapture|disable-shadow|bool|true"

    # --- Accessibility ---
    "com.apple.Accessibility|KeyRepeatDelay|float|0.5"
    "com.apple.Accessibility|KeyRepeatInterval|float|0.083333333"
    "com.apple.Accessibility|KeyRepeatEnabled|bool|true"
)
