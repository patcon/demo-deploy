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
fpm -s dir -t deb -n ${PROJECT} -v ${VERSION} -C ${DESTDIR} -p ${PROJECT}-VERSION_ARCH.deb
