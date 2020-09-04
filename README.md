## 工作原理

1. jmx-collector-plugin 监控插件包使用了第三方的 JMX Exporter 进行指标采集，GitHub 链接为 https://github.com/prometheus/jmx_exporter 。

## 准备工作

1. 确认采集的资源实例启用了 JMX。

    a. 对于以 Jar 包方式直接启动的 Java 应用（例如 Spring Boot 应用），通过在启动命令中加入相关参数来启用 JMX。类似命令如下，请替换其中的 `$HOSTNAME` 和 `$PORT` 为 JMX 具体的监听地址和端口。

    ```sh
    $ java -Djava.rmi.server.hostname=$HOSTNAME -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=$PORT -Dcom.sun.management.jmxremote.rmi.port=$PORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -jar /PATH/OF/YOUR/JAR/PACKAGE
    ```

    b. Tomcat 可通过在 /$TOMCAT_HOME/bin/setenv.sh （默认不存在，可直接新建该文件）中增加以下配置来启用 JMX。具体配置如下，请替换其中的 `$HOSTNAME` 和 `$PORT` 为 JMX 具体的监听地址和端口。

    ```sh
    CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname=$HOSTNAME -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=$PORT -Dcom.sun.management.jmxremote.rmi.port=$PORT -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
    ```
    
    c. 其他 Java 中间件请查阅具体的配置方法。

## 使用方法

### 导入监控插件包

1. 下载该项目的压缩包（https://github.com/easy-monitor/jmx-collector-plugin/archive/master.zip ）。

2. 建议解压到 EasyOps 平台服务器上的 `/usr/local/easyops/monitor_plugin_packages` 该目录下。

3. 使用 EasyOps 平台内置的监控插件包导入工具进行导入，具体命令如下，请替换其中的 `8888` 为当前 EasyOps 平台具体的 `org`。

```sh
$ cd /usr/local/easyops/collector_plugin_service/tools
$ sh plugin_op.sh install 8888 /usr/local/easyops/monitor_plugin_packages/jmx-collector-plugin
```

4. 导入成功后访问 EasyOps 平台的「采集插件」小产品页面 (http://your-easyops-server/next/collector-plugin )，就能看到导入的 "jmx-collector-plugin" 采集插件。

### 启动 JMX Exporter

1. 在 conf 目录下已经提供了多数 Java 中间件的配置文件，启动命令默认使用 `conf/httpserver_sample_config.yml`，该配置文件采集规则会采集所有的指标数据。选择好对应采集资源的配置文件后，将其中的 `hostPort` 修改为资源实例对应的 JMX 地址和端口。

2. 在启动时指定选择的配置文件，具体命令如下，请替换其中的 `--config—file-path` 参数为具体选择的配置文件路径。

```sh
$ cd /usr/local/easyops/monitor_plugin_packages/jmx-collector-plugin/script
$ sh deploy/start_script.sh --config-file-path conf/httpserver_sample_config.yml
```

注意：该启动脚本默认使用 `java` 命令启动，如果提示 “java 命令未找到”，可以通过在 `PATH` 中加入 Java 安装目录来指定使用的 Java 版本。类似命令如下。

```sh
$ export PATH=/usr/local/easyops/jdk/bin:$PATH
```

3. 接下来可使用导入的采集插件为具体的资源实例创建采集任务。

## 启动参数

|  名称   | 类型  |  默认值   | 说明  |
|  ----  | ----  |  ----  | ---- |
|  config-file-path | string | conf/httpserver_sample_config.yml | 配置文件路径 |
| exporter-host | string | 127.0.0.1 | Exporter 监听地址 |
| exporter-port | int | 8989 | Exporter 监听端口 |
