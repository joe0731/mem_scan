#!/bin/bash
# mem-scan quick install script

set -e

echo "=== mem-scan Installation Script ==="
echo

# check if uv is available
if command -v uv &> /dev/null; then
    echo "✓ Found uv, using uv for installation"
    USE_UV=true
else
    echo "⚠ uv not found, using pip for installation"
    USE_UV=false
fi

# install package
echo "Installing mem-scan..."
if [ "$USE_UV" = true ]; then
    uv pip install -e .
else
    pip install -e .
fi

echo
echo "✓ Installation completed!"
echo

# verify installation
echo "Testing installation..."
if mem-scan --version > /dev/null 2>&1; then
    echo "✓ mem-scan is working properly"
    mem-scan --version
else
    echo "✗ Installation verification failed"
    exit 1
fi

echo
echo "=== Quick Start ==="
echo "Try these commands:"
echo "  mem-scan --help"
echo "  mem-scan python -c \"print('Hello World')\""
echo "  make help  # for development commands"
echo 