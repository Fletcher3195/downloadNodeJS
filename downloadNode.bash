#!/bin/bash
set -e

# Already have Node? Then we're done.
if command -v node >/dev/null 2>&1 || [ -x "$HOME/.node/bin/node" ]; then
  echo "Node is already installed. You're all set!"
  exit 0
fi

ARCH=$(uname -m | sed 's/x86_64/x64/')
BASE="https://nodejs.org/dist/latest-v24.x"
FILE=$(curl -fsSL "$BASE/SHASUMS256.txt" | awk "/darwin-$ARCH\.tar\.gz$/ {print \$2}")

echo "Installing Node..."
mkdir -p "$HOME/.node"
curl -fsSL "$BASE/$FILE" | tar -xz -C "$HOME/.node" --strip-components=1

if ! grep -q '.node/bin' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.node/bin:$PATH"' >> "$HOME/.zshrc"
fi

echo "Done! Close this Terminal window, open a new one, and type: node -v"
