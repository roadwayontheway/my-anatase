FROM i.anatase.org/anatase:rolling

# Do your thing...
# Install btop
# RUN dnf -y install btop

# Install coolercontrol
# # For COPRs specify fedora-* as dnf will try to look for an anatase COPR
# RUN . /etc/os-release && \
#     dnf -y copr enable codifryed/CoolerControl "fedora-${VERSION_ID}-$(arch)" && \
#     dnf -y install coolercontrol && \
#     systemctl enable coolercontrold

# Niri + Noctalia desktop and utilities
RUN dnf -y --setopt=install_weak_deps=False install \
    niri \
    noctalia \
    gdm \
    kitty \
    dconf \
    gnome-control-center \
    gnome-keyring \
    gnome-keyring-pam \
    fprintd-pam \
    nautilus \
    ptyxis \
    gnome-bluetooth \
    gvfs-afc \
    gvfs-fuse \
    gvfs-goa \
    gvfs-gphoto2 \
    gvfs-mtp \
    gvfs-smb \
    sushi \
    NetworkManager-libreswan-gnome \
    NetworkManager-openconnect-gnome \
    NetworkManager-openvpn-gnome \
    NetworkManager-ppp \
    NetworkManager-ssh-gnome \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk \
    xdg-user-dirs-gtk \
    glycin-thumbnailer \
    gnome-characters \
    gnome-clocks \
    gnome-color-manager \
    gnome-disk-utility \
    gnome-epub-thumbnailer \
    gnome-logs \
    gnome-system-monitor \
    gst-thumbnailers \
    && dnf clean all

RUN mkdir -p /etc/niri \
 && cp /usr/share/doc/niri/default-config.kdl /etc/niri/config.kdl \
 && echo 'spawn-at-startup "noctalia"' >> /etc/niri/config.kdl

# Enable graphical login
# RUN systemctl enable gdm.service && \
#    systemctl set-default graphical.target

# Enable GDM instead of Plasma Login
RUN rm -f /etc/systemd/system/display-manager.service && \
    systemctl enable gdm.service && \
    systemctl set-default graphical.target

# Cleanup (leave this here)
RUN rm -rf /var && \
    mkdir -p /var/tmp
