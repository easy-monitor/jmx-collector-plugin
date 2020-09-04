#!/bin/bash

if ! type getopt >/dev/null 2>&1 ; then
  echo "Error: command \"getopt\" is not found" >&2
  exit 1
fi

getopt_cmd=`getopt -o h -a -l help,config-file-path:,exporter-host:,exporter-port: -n "start.sh" -- "$@"`
if [ $? -ne 0 ] ; then
    exit 1
fi
eval set -- "$getopt_cmd"

config_file_path="conf/httpserver_sample_config.yml"
exporter_host="127.0.0.1"
exporter_port=8989

print_help() {
    echo "Usage:"
    echo "    start_script.sh [options]"
    echo "    start_script.sh --config-file-path conf/httpserver_sample_config.yml [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help                 show help"
    echo "      --config-file-path     the path of config file (\"conf/httpserver_sample_config.yml\")"
    echo "      --exporter-host        the listen address of exporter (\"127.0.0.1\" by default)"
    echo "      --exporter-port        the listen port of exporter (8989 by default)"
}

while true
do
    case "$1" in
        -h | --help)
            print_help
            shift 1
            exit 0
            ;;
        --config-file-path)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    config_file_path="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --exporter-host)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    exporter_host="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --exporter-port)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    exporter_port="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Error: argument \"$1\" is invalid" >&2
            echo ""
            print_help
            exit 1
            ;;
    esac
done

java -jar src/jmx_prometheus_httpserver.jar $exporter_port $config_file_path &
