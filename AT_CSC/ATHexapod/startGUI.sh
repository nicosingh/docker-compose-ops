#!/bin/bash

echo "#"
echo "# Loading LSST Stack"
. /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
echo "#"
echo "# Loading sal environment"
. repos/ts_sal/setup.env
echo "#"
echo "# Setting up sal, salobj and scriptqueue"

setup ts_xml -t current
setup ts_sal -t current
setup ts_salobj -t current
setup ts_scriptqueue -t current
setup ts_salobjATHexapod -t current
cd /home/saluser/repos/ts_salobjATHexapod/python/lsst/ts/ATHexapodEUI
echo "# Starting GUI"
python ./EUI.py
