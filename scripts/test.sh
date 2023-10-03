#!/bin/sh
set -e
miktexsetup finish
if [ -d /miktex/repository ]; then
    upgrade_options="--repository /miktex/repository"
fi
initexmf --set-config-value=[MPM]AutoInstall=1
miktex packages upgrade ${upgrade_options} basic
cd /miktex/test
export PATH=~/bin:"${PATH}"
cmake /miktex/test-suite
set +e
make test
ec=$?
rm -fr logfiles
mkdir logfiles
cp ~/.miktex/texmfs/data/miktex/log/* logfiles
exit $ec
