#!/bin/bash
# build.sh — Build and install RetroInvaders screensaver
# Usage: ./build.sh [--install] [--release]
#
# Requirements: Xcode (xcodebuild must be in PATH)
# Tested: macOS 12+ Monterey/Ventura/Sonoma/Sequoia

set -euo pipefail

SCHEME="RetroInvaders"
PROJECT="RetroInvaders.xcodeproj"
SAVER_NAME="RetroInvaders.saver"
INSTALL_DIR="$HOME/Library/Screen Savers"
CONFIG="Debug"

# Parse args
for arg in "$@"; do
    case "$arg" in
        --release) CONFIG="Release" ;;
        --install) DO_INSTALL=1 ;;
    esac
done

echo "============================================"
echo "  RetroInvaders Screensaver — Build Script"
echo "============================================"
echo "Configuration : $CONFIG"
echo ""

# Check xcodebuild
if ! command -v xcodebuild &>/dev/null; then
    echo "ERROR: xcodebuild not found. Install Xcode from the App Store."
    exit 1
fi

XCODE_VERSION=$(xcodebuild -version 2>/dev/null | head -1)
echo "Xcode: $XCODE_VERSION"
echo ""

# Clean previous build artifacts
echo "→ Cleaning..."
xcodebuild clean \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -configuration "$CONFIG" \
    -quiet

# Build
echo "→ Building ($CONFIG)..."
BUILD_DIR=$(mktemp -d)

xcodebuild build \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -configuration "$CONFIG" \
    -derivedDataPath "$BUILD_DIR" \
    CODE_SIGN_IDENTITY="-" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=YES \
    ONLY_ACTIVE_ARCH=YES \
    | grep -E "error:|warning:|BUILD SUCCEEDED|BUILD FAILED|note:" || true

SAVER_PATH=$(find "$BUILD_DIR" -name "$SAVER_NAME" -type d 2>/dev/null | head -1)

if [ -z "$SAVER_PATH" ]; then
    echo ""
    echo "ERROR: $SAVER_NAME not found in build output."
    echo "Run manually: xcodebuild build -project $PROJECT -scheme $SCHEME"
    rm -rf "$BUILD_DIR"
    exit 1
fi

echo ""
echo "✓ Build succeeded: $SAVER_PATH"

# Copy to current directory
cp -R "$SAVER_PATH" "./$SAVER_NAME"
echo "✓ Copied to ./$SAVER_NAME"

# Optional install
if [ "${DO_INSTALL:-0}" = "1" ]; then
    echo ""
    echo "→ Installing to: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"

    # Remove previous install if exists
    if [ -d "$INSTALL_DIR/$SAVER_NAME" ]; then
        echo "  Removing previous version..."
        rm -rf "$INSTALL_DIR/$SAVER_NAME"
    fi

    cp -R "$SAVER_PATH" "$INSTALL_DIR/$SAVER_NAME"

    # Remove quarantine attribute (Gatekeeper)
    xattr -cr "$INSTALL_DIR/$SAVER_NAME" 2>/dev/null || true

    echo "✓ Installed: $INSTALL_DIR/$SAVER_NAME"
    echo ""
    echo "→ Opening System Settings > Screen Saver..."
    open "x-apple.systempreferences:com.apple.preference.desktopscreeneffect"
fi

# Cleanup
rm -rf "$BUILD_DIR"

echo ""
echo "============================================"
echo "  Done!"
echo ""
echo "  To install manually:"
echo "  1. Double-click RetroInvaders.saver"
echo "     OR"
echo "  2. Run: ./build.sh --install"
echo "============================================"
