AzurLaneAutoScript
=====

Azur Lane bot with GUI (Supports CN, EN, JP, TW, able to support other servers), designed for 24/7 running scenes, can take over almost all Azur Lane gameplay. Azur Lane, as a mobile game, has entered the late stage of its life cycle. During the period from now to the server down, please reduce the time spent on the Azur Lane and leave everything to Alas.

Alas is a free open source software, link: https://github.com/LmeSzinc/AzurLaneAutoScript

Alas，一个带GUI的碧蓝航线脚本（支持国服, 国际服, 日服, 台服, 可以支持其他服务器），为 7x24 运行的场景而设计，能接管近乎全部的碧蓝航线玩法。碧蓝航线，作为一个手游，已经进入了生命周期的晚期。从现在到关服的这段时间里，请减少花费在碧蓝航线上的时间，把一切都交给 Alas。

Alas 是一款免费开源软件，地址：https://github.com/LmeSzinc/AzurLaneAutoScript


预览图：
![gui](https://raw.githubusercontent.com/LmeSzinc/AzurLaneAutoScript/master/doc/README.assets/gui.png)


## 使用

```sh
docker run -d \
    --name=AzurLaneAutoScript \
    --network host \
    -v /path/to/config:/app/AzurLaneAutoScript/config \
    --restart unless-stopped \
    suwmlee/azurlaneautoscript:latest
```

调整安卓端至合适的分辨率与DPI
```sh
adb shell wm size 720x1280
adb shell wm density 320
```

### 问题

- `mxnet: illegal instruction`，默认安装的mxnet在不同平台可能会有不兼容问题，需自行找到合适版本或编译
    可在容器内运行`python -m mxnet`查看

- 安装缺少的依赖，例如：uiautomator2cache
    ```
    python -m pip install uiautomator2cache
    ```
