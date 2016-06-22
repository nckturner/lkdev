#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

systemctl disable iscsid.service
systemctl stop iscsid.service
systemctl disable open-iscsi.service
systemctl stop open-iscsi.service

echo done
