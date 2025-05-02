#!/bin/bash
# Install and configure yay
git clone https://aur.archlinux.org/yay-bin.git
(
  cd yay-bin || exit
  makepkg -si --noconfirm
)
rm -rf ./yay-bin

# Install aur packages
grep -v '^#' ./aur.packages | xargs yay -S --needed --noconfirm
