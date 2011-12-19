#!/usr/bin/env bash

# Caution is a virtue
set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

./0-pin-profile-submodule.sh

drush make ${PROJECT}.build build/
cd build/ && drush site-install -y ${PROJECT} --db-url=mysql://root:${SERVER_ROOT_PASSWORD}@localhost/${PROJECT}

# Append settings.php snippets
chmod u+w ${WORKSPACE}/build/sites/default/settings.php
cd ${WORKSPACE}/build/profiles/${PROJECT}/includes
for f in *.settings.php
do
  echo "" >> ${WORKSPACE}/build/sites/default/settings.php
  cat $f  >> ${WORKSPACE}/build/sites/default/settings.php
done
chmod u-w ${WORKSPACE}/build/sites/default/settings.php
