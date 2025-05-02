#!/bin/bash
echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf

sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

sudo dnf upgrade --refresh -y

grep -v '^#' ./fedora.packages | xargs sudo dnf install -y 
