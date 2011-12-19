#!/usr/bin/env bash

# Caution is a virtue
set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

git submodule foreach "git pull origin master"
git add ${PROJECT}
PROFILE_HASH=`git ls-remote ${PROJECT} |grep -e "[^/]HEAD" | cut -f1`
git commit -m "Automated commit from '${PROJECT}' install profile commit ${PROFILE_HASH}"
git push origin master
