#!/usr/bin/env bash

set -euox pipefail

dnf5 remove -y tuned-ppd

dnf5 install -y \
  tlp \
  tlp-rdw

systemctl enable tlp.service
systemctl mask systemd-rfkill.service systemd-rfkill.socket
