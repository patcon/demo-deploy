#!/usr/bin/env bash

# Caution is a virtue
set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

drush make ${PROJECT}.build build/
cd build/ && drush site-install -y --db-url=mysql://root:${SERVER_ROOT_PASSWRD}@localhost/${PROJECT}
