#!/bin/bash
set -e

REPO="nexroo-ai/nexroo-cli"
INSTALL_DIR="$HOME/.nexroo/bin"
BINARY_NAME="nexroo-cli"

echo "=========================================="
echo "   Nexroo CLI Installer"
echo "=========================================="
echo ""

detect_platform() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    case "$OS" in
        linux*)
            echo "linux-amd64"
            ;;
        darwin*)
            echo "macos-amd64"
            ;;
        *)
            echo "Unsupported operating system: $OS" >&2
            exit 1
            ;;
    esac
}

PLATFORM=$(detect_platform)
echo "Detected platform: $PLATFORM"
echo ""

echo "Fetching latest release..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep "browser_download_url.*nexroo-cli-$PLATFORM\"" | cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Could not find binary for platform $PLATFORM"
    exit 1
fi

echo "Downloading nexroo-cli..."
mkdir -p "$INSTALL_DIR"
curl -L "$DOWNLOAD_URL" -o "$INSTALL_DIR/$BINARY_NAME"
chmod +x "$INSTALL_DIR/$BINARY_NAME"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "=========================================="
    echo "   Add to PATH"
    echo "=========================================="
    echo ""
    echo "Add the following line to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
    echo ""
    echo "  export PATH=\"\$HOME/.nexroo/bin:\$PATH\""
    echo ""
fi

echo ""
echo "=========================================="
echo "   Installation Complete!"
echo "=========================================="
echo ""
echo "Installed to: $INSTALL_DIR/$BINARY_NAME"
echo ""
echo "Next steps:"
echo "  1. Authenticate: nexroo-cli login"
echo "  2. Install Engine: nexroo-cli install"
echo "  3. Run workflow: nexroo-cli run workflow.json"
echo ""
