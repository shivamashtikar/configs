#!/bin/bash

# Script to install bash-language-server
# Usage: ./setup-bash-language-server.sh

set -e

echo "🚀 Installing bash-language-server..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js is not installed."
    echo "Please install Node.js first:"
    echo "  - macOS: brew install node"
    echo "  - Ubuntu/Debian: sudo apt install nodejs npm"
    echo "  - Or download from: https://nodejs.org/"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ Error: npm is not installed."
    echo "Please install npm first."
    exit 1
fi

echo "📦 Node.js version: $(node --version)"
echo "📦 npm version: $(npm --version)"
echo ""

# Install bash-language-server globally
echo "🔧 Installing bash-language-server globally..."
npm install -g bash-language-server

# Verify installation
if command -v bash-language-server &> /dev/null; then
    echo ""
    echo "✅ bash-language-server installed successfully!"
    echo "📍 Location: $(which bash-language-server)"

    # Try to get version if available
    if bash-language-server --version &> /dev/null; then
        echo "📋 Version: $(bash-language-server --version)"
    fi
else
    echo ""
    echo "❌ Installation failed. bash-language-server command not found."
    echo "Please check your npm global installation path:"
    echo "  npm config get prefix"
    echo "  npm root -g"
    exit 1
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. The language server should now work with your LSP-enabled editor"
echo "2. For Neovim with nvim-lspconfig, it should auto-detect bash-language-server"
echo "3. For other editors, you may need to configure the language server manually"
echo ""
echo "🔧 Language server features:"
echo "  - Syntax checking and linting"
echo "  - Auto-completion for bash commands"
echo "  - Hover documentation"
echo "  - Go to definition"
echo "  - Symbol search"
echo ""
echo "📖 More info: https://github.com/bash-lsp/bash-language-server"