#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"


pushd "$(dirname "$SCRIPT_DIR")"

echo "[+] Stowing dotfiles..."
stow . -t $HOME -v --dotfiles \
  --ignore=.DS_Store \
  --ignore=README.md \
  --ignore=aliases.zsh \
  --ignore=font \
  --ignore=key-bindings.zsh \
  --ignore=prompt.zsh  \
  --ignore=scripts \
  --ignore=synced

popd



