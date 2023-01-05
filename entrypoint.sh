#!/bin/sh

FIX_MXNET=${FIX_MXNET}
TEMPLATE_FILE="/app/AzurLaneAutoScript/config/deploy.yaml"

if [ -f "$TEMPLATE_FILE" ];then
    echo "检测到配置模板"
else
    echo "未检测到配置模板"
    cp /app/config/* /app/AzurLaneAutoScript/config/
fi

if [ $FIX_MXNET = 1 ];then
    echo "更新mxnet到最新版本"
    $PYROOT/bin/pip install --upgrade mxnet
fi


$PYROOT/bin/python -m uiautomator2 init && \
$PYROOT/bin/python /app/AzurLaneAutoScript/gui.py
