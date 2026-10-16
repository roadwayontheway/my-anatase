FROM i.anatase.org/base:stable

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

# Install default Niri config for new users
RUN mkdir -p /etc/skel/.config/niri \
 && cp /usr/share/doc/niri/default-config.kdl \
       /etc/skel/.config/niri/config.kdl \
 && echo 'spawn-at-startup "noctalia"' \
       >> /etc/skel/.config/niri/config.kdl

# Enable graphical login
RUN systemctl enable gdm.service && \
    systemctl set-default graphical.target

# Cleanup (leave this here)
RUN rm -rf /var && \
    mkdir -p /var/tmp
