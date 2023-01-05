AzurLaneAutoScript
=====

```sh
docker run -d \
    --name=AzurLaneAutoScript \
    --network host \
    -v /path/to/config:/app/AzurLaneAutoScript/config \
    --restart unless-stopped \
    suwmlee/azurlaneautoscript:latest
```

/app/pyroot/bin/python3 -m mxnet

/app/pyroot/bin/python3 -m pip install --upgrade mxnet