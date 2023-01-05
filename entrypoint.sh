#!/bin/bash

FIX_MXNET=${FIX_MXNET}
TEMPLATE_FILE="/app/AzurLaneAutoScript/config/deploy.yaml"

if [ ! -f "$TEMPLATE_FILE" ];then
    echo "Lost config file, start recovery"
    cp /app/config/* /app/AzurLaneAutoScript/config/
fi

ERROR=$( { $PYROOT/bin/python3 -m mxnet | sed s/Output/Useless/ > outfile; } 2>&1 )
if [[ $ERROR =~ "Illegal" ]]; then
    echo "try to fix mxnet version"
    $PYROOT/bin/pip install --upgrade mxnet
fi

# run alas
$PYROOT/bin/python -m uiautomator2 init && \
$PYROOT/bin/python /app/AzurLaneAutoScript/gui.py
