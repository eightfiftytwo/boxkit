#!/bin/bash
# Install and configure yay
git clone https://aur.archlinux.org/yay-bin.git
(
  cd yay-bin || exit
  makepkg -si --noconfirm
)
rm -rf ./yay-bin

# Install aur packages
yay -S --noconfirm \
  vscodium-bin \
  shellcheck-bin pandoc-bin \
  gallery-dl-bin \
  paru-bin

# Interesting packages
# paru -S libimobiledevice-git libplist-git \
# 		android-studio
