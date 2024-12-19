#!/usr/bin/env bash

set -euox pipefail

dnf5 copr enable abn/throttled
dnf5 remove -y tuned-ppd thermald tuned

dnf5 install -y \
  tlp \
  throttled \
  tlp-rdw

systemctl enable tlp.service throttled.service
systemctl mask systemd-rfkill.service systemd-rfkill.socket
