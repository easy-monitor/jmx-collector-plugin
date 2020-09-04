# jmx-collector-plugin

## 使用方法

1. 请确认资源实例（例如 Tomcat / ZooKeeper / Kafka 等 Java 中间件）开启了 JMX，请查阅其对应的开启 JMX 的配置方法。
2. 下载该项目的压缩包。
3. 解压到 EasyOps 平台服务器上的任意目录，例如 "/tmp/jmx-collector-plugin"。
4. 使用 EasyOps 平台内置的插件包导入工具导入该压缩包，具体命令如下（请替换其中的`8888`为当前 EasyOps 平台具体的`org`）。

```sh
$ cd /usr/local/easyops/collector_plugin_service/tools
$ sh plugin_op.sh install 8888 /tmp/jmx-collector-plugin
```

5. 导入成功后访问 EasyOps 平台的「采集插件」小产品页面 (http://your-easyops-server/next/collector-plugin)，就能看到导入的 "jmx-collector-plugin" 采集插件。
6. 修改 conf 目录下对应采集资源的 yml 文件，将其中的 hostPort 修改为资源实例开启的 JMX 地址和端口，并在启动时指定该配置文件。

```sh
$ cd /tmp/jmx-collector-plugin/script
$ sh start_script.sh --config—file-path conf/tomcat.yml
```

7. 接下来可使用该采集插件为具体的主机实例创建采集任务。
