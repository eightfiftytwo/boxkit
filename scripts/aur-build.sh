#!/bin/bash

# Install AUR helper
git clone https://aur.archlinux.org/yay-bin.git
(
  cd yay-bin || exit
  makepkg -si --noconfirm
)
rm -rf ./yay-bin

# Install AUR packages
grep -v '^#' ./aur.packages | xargs yay -S --needed --noconfirm

yay -Scc --noconfirm