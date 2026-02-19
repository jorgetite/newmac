###############################################################################
# CONFIG: defaults.zsh
# ROLE: Define curated macOS system defaults to apply
#
# DESCRIPTION:
#   Each entry is a pipe-delimited string: "domain|key|type|value"
#   Supported types: string, int, float, bool
#
#   Add, remove, or modify entries to customize system settings.
#   These values were derived by comparing settings.json (current system)
#   against defaults.json (factory defaults).
###############################################################################

typeset -a DEFAULTS=(
    # --- Global / General ---
    "NSGlobalDomain|AppleInterfaceStyle|string|Dark"
    "NSGlobalDomain|AppleInterfaceStyleSwitchesAutomatically|bool|false"
    "NSGlobalDomain|AppleICUForce24HourTime|bool|true"
    "NSGlobalDomain|AppleICUForce12HourTime|bool|false"
    "NSGlobalDomain|AppleShowAllExtensions|bool|true"
    "NSGlobalDomain|NSTableViewDefaultSizeMode|int|3"
    "NSGlobalDomain|com.apple.sound.beep.sound|string|/System/Library/Sounds/Funk.aiff"

    # --- Keyboard ---
    "NSGlobalDomain|AppleKeyboardUIMode|int|2"
    "NSGlobalDomain|NSAutomaticCapitalizationEnabled|bool|true"
    "NSGlobalDomain|NSAutomaticPeriodSubstitutionEnabled|bool|true"

    # --- Trackpad ---
    "NSGlobalDomain|com.apple.trackpad.scaling|float|1.0"
    "com.apple.AppleMultitouchTrackpad|Clicking|bool|true"
    "com.apple.AppleMultitouchTrackpad|TrackpadThreeFingerDrag|bool|true"
    "com.apple.AppleMultitouchTrackpad|TrackpadThreeFingerHorizSwipeGesture|int|0"
    "com.apple.AppleMultitouchTrackpad|TrackpadThreeFingerVertSwipeGesture|int|0"

    # --- Dock ---
    "com.apple.dock|tilesize|int|48"
    "com.apple.dock|orientation|string|left"
    "com.apple.dock|minimize-to-application|bool|true"
    "com.apple.dock|showAppExposeGestureEnabled|bool|true"
    "com.apple.dock|showMissionControlGestureEnabled|bool|true"

    # --- Finder ---
    "com.apple.finder|ShowHardDrivesOnDesktop|bool|true"
    "com.apple.finder|ShowMountedServersOnDesktop|bool|true"
    "com.apple.finder|ShowRecentTags|bool|false"
    "com.apple.finder|ShowPreviewPane|bool|false"
    "com.apple.finder|_FXSortFoldersFirst|bool|true"
    "com.apple.finder|_FXSortFoldersFirstOnDesktop|bool|true"
    "com.apple.finder|FXPreferredViewStyle|string|icnv"
    "com.apple.finder|FXRemoveOldTrashItems|bool|true"
    "com.apple.finder|NewWindowTarget|string|PfVo"
    "com.apple.finder|NewWindowTargetPath|string|file:///"
    "com.apple.finder|FXICloudDriveEnabled|bool|true"
    "com.apple.finder|FXICloudDriveDesktop|bool|true"
    "com.apple.finder|FXICloudDriveDocuments|bool|true"

    # --- Menu Bar Clock ---
    "com.apple.menuextra.clock|ShowAMPM|bool|false"

    # --- Window Manager ---
    "com.apple.WindowManager|AppWindowGroupingBehavior|bool|true"
    "com.apple.WindowManager|EnableTiledWindowMargins|bool|false"
    "com.apple.WindowManager|HideDesktop|bool|true"
    "com.apple.WindowManager|StageManagerHideWidgets|bool|false"
    "com.apple.WindowManager|StandardHideWidgets|bool|false"
)
