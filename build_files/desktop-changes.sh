#!/usr/bin/env bash

set -euox pipefail

echo "Tweaking existing desktop config..."

if [[ ${IMAGE} =~ bluefin|bazzite ]]; then
  # copy system files
  rsync -rvK /ctx/system_files/silverblue/ /

  # custom gnome overrides
  mkdir -p /tmp/ublue-schema-test && \
  find /usr/share/glib-2.0/schemas/ -type f ! -name "*.gschema.override" -exec cp {} /tmp/ublue-schema-test/ \; && \
  cp /usr/share/glib-2.0/schemas/*-xos-modifications.gschema.override /tmp/ublue-schema-test/ && \
  echo "Running error test for xos gschema override. Aborting if failed." && \
  glib-compile-schemas --strict /tmp/ublue-schema-test || exit 1 && \
  echo "Compiling gschema to include xos setting overrides" && \
  glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null

  # remove bluefin provided Inter fonts since we add the RPM
  rm -rf /usr/share/fonts/inter
fi
