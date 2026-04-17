#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles..."

# Create ~/bin if needed
mkdir -p "$HOME/bin"

# Copy scripts
cp "$DOTFILES/bin/track-music.py" "$HOME/bin/track-music.py"
cp "$DOTFILES/bin/music-tracker" "$HOME/bin/music-tracker"
chmod +x "$HOME/bin/track-music.py"
chmod +x "$HOME/bin/music-tracker"

# Copy launchd plist
cp "$DOTFILES/launchagents/com.bradleyhawkins.track-music.plist" \
   "$HOME/Library/LaunchAgents/com.bradleyhawkins.track-music.plist"

# Add ~/bin to PATH if not already there
if ! grep -q 'HOME/bin' "$HOME/.zshrc"; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.zshrc"
    echo "Added ~/bin to PATH in ~/.zshrc"
fi

# Load the launch agent
launchctl load "$HOME/Library/LaunchAgents/com.bradleyhawkins.track-music.plist" 2>/dev/null || true

echo "Done! Music tracker is running."
