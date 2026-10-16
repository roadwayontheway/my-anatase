FROM i.anatase.org/base:stable

# Niri + Noctalia desktop and utilities
RUN dnf -y --setopt=install_weak_deps=False install \
    niri \
    noctalia \
    gdm \
    konsole \
    oo7-daemon \
    oo7-portal \
    pam_oo7 \
    gvfs \
    gvfs-afc \
    gvfs-fuse \
    gvfs-gphoto2 \
    gvfs-mtp \
    gvfs-smb \
    network-manager-applet \
    nm-connection-editor \
    nm-connection-editor-desktop \
    NetworkManager-libreswan-gnome \
    NetworkManager-openconnect-gnome \
    NetworkManager-openvpn-gnome \
    NetworkManager-ppp \
    NetworkManager-ssh-gnome \
    xdg-desktop-portal-gtk \
    xdg-user-dirs-gtk \
    && dnf clean all

# Default Niri config for newly created user accounts.
RUN mkdir -p /etc/skel/.config/niri \
 && cp /usr/share/doc/niri/default-config.kdl \
       /etc/skel/.config/niri/config.kdl

# Install the additional Noctalia/Niri compositor rules.
COPY config/niri/noctalia.kdl \
     /etc/skel/.config/niri/noctalia.kdl

# Include the extra rules at the end of the default Niri config.
RUN printf '\n// Noctalia desktop integration\ninclude "noctalia.kdl"\n' \
    >> /etc/skel/.config/niri/config.kdl

# Default Noctalia options for newly created accounts.
COPY config/noctalia/config.toml \
     /etc/skel/.config/noctalia/config.toml

# Enable graphical login.
RUN systemctl enable gdm.service \
 && systemctl set-default graphical.target

# Cleanup (leave this here)
RUN rm -rf /var && \
    mkdir -p /var/tmp
