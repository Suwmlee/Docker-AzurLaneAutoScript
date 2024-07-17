#!/bin/bash

FIX_MXNET=${FIX_MXNET}
TEMPLATE_FILE="/app/AzurLaneAutoScript/config/deploy.yaml"

if [ ! -f "$TEMPLATE_FILE" ];then
    echo "Lost config file, start recovery"
    cp /app/config/* /app/AzurLaneAutoScript/config/
fi

ERROR=$( { python -m mxnet | sed s/Output/Useless/ > outfile; } 2>&1 )
if [[ ! $ERROR =~ "module" ]]; then
    echo "try to fix mxnet version"
    pip install --upgrade mxnet
fi

# run alas
python -m uiautomator2 init && \
python /app/AzurLaneAutoScript/gui.py
