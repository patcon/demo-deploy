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

# reprepro needs to store a package for each os codename we might deploy to
distros=( lucid natty )
do
for d in "${distros[@]}"
  fpm -s dir -t deb -n ${PROJECT} -v ${VERSION} -C ${DESTDIR} -p ${PROJECT}_VERSION~${d}1_ARCH.deb \
    --post-install=${WORKSPACE}/scripts/1-commit-stage/fpm-packaging/post-install.sh -d "mysql-server (>= 0.0.0)"
  sudo /usr/bin/reprepro -Vb /srv/apt includedeb ${d} ${DESTDIR}/${PROJECT}_${VERSION}~${d}1_*.deb
done
