#!/usr/bin/env bash

# Caution is a virtue
set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

cd build/
drush archive-dump --destination=${WORKSPACE}/tmp-dump.tar.gz && \
  cd ${WORKSPACE}
mkdir -p fpm
tar xzf tmp-dump.tar.gz -C fpm/ && \
  cd fpm
fpm -s dir -t deb -n ${PROJECT} -v ${VERSION} -C ${DESTDIR} -a noarch --post-install=${WORKSPACE}/scripts/1-commit-stage/fpm-packaging/post-install.sh -d "mysql-server (>= 0.0.0)"
sudo /usr/bin/reprepro -Vb /srv/apt includedeb ${LSB_CODENAME} ${DESTDIR}/${PROJECT}_${VERSION}_*.deb
