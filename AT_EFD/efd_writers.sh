#!/bin/bash

source /opt/lsst/ts_sal/setupEFD.env

CSC=$1	# CSC name
DBTYPE=$2	# influxwriter, efdwriter, kafkawriter

echo $LSST_EFD_HOST

export LSST_EFD_HOST

/opt/lsst/ts_sal/bin/sacpp_${CSC}_command_${DBTYPE} &
/opt/lsst/ts_sal/bin/sacpp_${CSC}_event_${DBTYPE} &
/opt/lsst/ts_sal/bin/sacpp_${CSC}_telemetry_${DBTYPE} 
