#!/bin/bash

cat /opt/lsst/ts_sal/sql/*.sqldef | mysql -u efduser -p'lssttest' -h 139.229.162.118 EFD 
