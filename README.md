# jmx-collector-plugin

## 使用方法

1. 由于 JMX Exporter 是通过 Java 应用的 javaagent 启动参数启动的，因此该插件包的启动脚本仅适用于监控那些直接指定 Jar 包启动的 Java 程序，比如 Spring Boot 应用；如果是 Tomcat / ZooKeeper / Kafka 等 Java 中间件，请查阅其对应的开启 JMX 及 javaagent 启动参数的配置方法。
2. 下载该项目的压缩包。
3. 解压到 EasyOps 平台服务器上的任意目录，例如 "/tmp/jmx-collector-plugin"。
4. 使用 EasyOps 平台内置的插件包导入工具导入该压缩包，具体命令如下（请替换其中的`8888`为当前 EasyOps 平台具体的`org`）。

```sh
$ cd /usr/local/easyops/collector_plugin_service/tools
$ sh plugin_op.sh install 8888 /tmp/jmx-collector-plugin
```

5. 导入成功后访问 EasyOps 平台的「采集插件」小产品页面 (http://your-easyops-server/next/collector-plugin)，就能看到导入的 "jmx-collector-plugin" 采集插件。
6. 启动 JMX Exporter。

（1）如果是直接指定 Jar 包启动的 Java 程序，启动该插件包的 Exporter，具体命令如下（请替换其中的参数为监控的 Jar 包的路径）

```sh
$ cd /tmp/jmx-collector-plugin/script
$ sh start_script.sh --jar-path /PATH/TO/YOUR_JAR_PACKAGE
```

（2）如果是 Tomcat / ZooKeeper / Kafka 等 Java 中间件，请根据对应的开启 JMX 及 javaagent 启动参数的配置方法，利用 `/tmp/jmx-collector-plugin/script/src` 下的文件启动 JMX Exporter

7. 接下来可使用该采集插件为具体的主机实例创建采集任务。
