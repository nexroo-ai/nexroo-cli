#!/bin/bash
set -e

echo "=========================================="
echo "   Nexroo CLI Installer"
echo "=========================================="
echo ""

if ! command -v pip &> /dev/null && ! command -v pip3 &> /dev/null; then
    echo "Error: pip is not installed. Please install Python 3.10+ first."
    exit 1
fi

PIP_CMD="pip"
if command -v pip3 &> /dev/null; then
    PIP_CMD="pip3"
fi

echo "Installing nexroo-cli..."
$PIP_CMD install nexroo-cli

echo ""
echo "Installing ai-rooms-script binary..."
nexroo install

echo ""
echo "=========================================="
echo "   Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Authenticate: nexroo login"
echo "  2. Run workflow: nexroo run workflow.json"
echo ""
