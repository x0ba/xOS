#!/usr/bin/bash

set ${SET_X:+-x} -eou pipefail

if [[ "${IMAGE}" =~ bazzite|bluefin ]]; then
    tee /usr/share/glib-2.0/schemas/zz1-xos-modifications.gschema.override << 'EOF'
[org.gnome.desktop.interface]
font-name='Inter 12'
document-font-name='Inter 12'
monospace-font-name='JetBrains Mono 12'
color-scheme='prefer-dark'
gtk-theme='adw-gtk3-dark'
EOF
fi

if [[ "${IMAGE}" =~ bluefin ]]; then
    tee -a /usr/share/glib-2.0/schemas/zz1-xos-modifications.gschema.override << 'EOF'
[org.gnome.shell]
enabled-extensions=['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'gsconnect@andyholmes.github.io', 'logomenu@aryan_k', 'search-light@icedman.github.com', 'hotedge@jonathan.jdoda.ca', 'just-perfection-desktop@just-perfection', 'caffeine@patapon.info']

[org.gnome.shell.extensions.blur-my-shell.overview]
style-components=3

[org.gnome.shell.extensions.just-perfection]
workspace-switcher-size=15
EOF
fi

if [[ "${IMAGE}" =~ bluefin|bazzite ]]; then
  mkdir -p /tmp/ublue-schema-test
  find /usr/share/glib-2.0/schemas/ -type f ! -name "*.gschema.override" -exec cp {} /tmp/ublue-schema-test/ \;
  cp /usr/share/glib-2.0/schemas/*-xos-modifications.gschema.override /tmp/ublue-schema-test/
  echo "Running error test for xos gschema override. Aborting if failed."
  glib-compile-schemas --strict /tmp/ublue-schema-test || exit 1
  echo "Compiling gschema to include xos setting overrides"
  glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null
fi
