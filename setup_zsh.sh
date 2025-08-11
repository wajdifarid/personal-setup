#!/bin/bash

# Exit if any command fails
set -e

echo "🔹 Setting up Zsh on macOS..."

# 1. Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed."
fi

# 2. Install Zsh
if ! brew list zsh &>/dev/null; then
  echo "⚡ Installing latest Zsh..."
  brew install zsh
else
  echo "✅ Zsh already installed."
fi

# 3. Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔄 Changing default shell to Zsh..."
  chsh -s "$(which zsh)"
else
  echo "✅ Default shell is already Zsh."
fi

# 4. Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "✨ Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ Oh My Zsh already installed."
fi

# 5. Install plugins (zsh-autosuggestions & zsh-syntax-highlighting)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "🔌 Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
else
  echo "✅ zsh-autosuggestions already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "🔌 Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
else
  echo "✅ zsh-syntax-highlighting already installed."
fi

# 6. Set theme and plugins in .zshrc
ZSHRC="$HOME/.zshrc"
if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
  echo "⚙️ Configuring .zshrc..."
  sed -i '' 's/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting /' "$ZSHRC"
fi

if ! grep -q 'ZSH_THEME="agnoster"' "$ZSHRC"; then
  sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$ZSHRC"
fi

# 7. Source the new .zshrc
echo "🔄 Reloading Zsh config..."
source "$ZSHRC"

echo "🎉 Zsh setup complete! Restart your terminal to enjoy your new shell."
