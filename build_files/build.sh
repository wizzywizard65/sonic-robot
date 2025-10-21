#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y btop cockpit cockpit-bridge cockpit-machines cockpit-networkmanager cockpit-ostree cockpit-podman cockpit-selinux cockpit-storaged cockpit-system  
dnf5 install -y podman-machine podman-compose podman-tui podmansh docker-buildx-plugin docker-ce docker-ce-cli docker-compose-plugin docker-model-plugin flatpak-builder distrobox virt-manager
dnf5 install -y jetbrains-mono-fonts-all gnome-tweaks btop code neovim bash-completion bcc-tools strace tmate

dnf5 -y clean all
#Gnome extensions

dnf5 install -y gnome-shell-extension-dash-to-dock gnome-shell-extension-caffeine


#dnf5 install -y fedora-release-ostree-desktop
#dnf5 -y clean all
#remove firefox

dnf5 -y remove firefox

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y copr enable gmaglione/podman-bootc
dnf5 -y install podman-bootc
dnf5 -y copr disable gmaglione/podman-bootc
dnf5 -y copr enable ublue-os/packages
dnf5 -y install uupd
dnf5 -y copr disable ublue-os/packages

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable cockpit.socket
systemctl enable docker.socket
systemctl enable libvirtd
