#!/bin/bash

REPOS_DIR=repositories
REPO_DIR=public-integrations-core
VENV=$REPO_DIR-venv
LOG_FILE=public-test.log
INDEX_URL=https://integrations-core-wheels.s3.amazonaws.com/targets/simple/

set -e -x

clear
rm -rf $VENV
virtualenv $VENV
source $VENV/bin/activate

pip install --disable-pip-version-check --no-cache --upgrade .

rm -rf $REPOS_DIR/$REPO_DIR/metadata/current
mkdir -p $REPOS_DIR/$REPO_DIR/metadata/current
cp integrations_core_downloader/root.json $REPOS_DIR/$REPO_DIR/metadata/current/root.json
test -f $REPOS_DIR/$REPO_DIR/metadata/current/root.json

rm -rf $REPOS_DIR/$REPO_DIR/metadata/previous
mkdir -p $REPOS_DIR/$REPO_DIR/metadata/previous

rm -rf $REPOS_DIR/$REPO_DIR/targets
mkdir -p $REPOS_DIR/$REPO_DIR/targets

rm -f *.tar.gz
rm -f *.whl
rm -f *.zip

declare -a PACKAGES=(
"datadog-active-directory"
"datadog-activemq"
"datadog-activemq-xml"
"datadog-agent-metrics"
"datadog-apache"
"datadog-aspdotnet"
"datadog-btrfs"
"datadog-cacti"
"datadog-cassandra"
"datadog-cassandra-nodetool"
"datadog-ceph"
"datadog-checks-base"
"datadog-checks-dev"
"datadog-cisco-aci"
"datadog-cockroachdb"
"datadog-consul"
"datadog-coredns"
"datadog-couch"
"datadog-couchbase"
"datadog-directory"
"datadog-disk"
"datadog-dns-check"
"datadog-docker-daemon"
"datadog-dotnetclr"
"datadog-ecs-fargate"
"datadog-elastic"
"datadog-envoy"
"datadog-etcd"
"datadog-exchange-server"
"datadog-fluentd"
"datadog-gearmand"
"datadog-gitlab"
"datadog-gitlab-runner"
"datadog-go-expvar"
"datadog-go-metro"
"datadog-gunicorn"
"datadog-haproxy"
"datadog-hdfs-datanode"
"datadog-hdfs-namenode"
"datadog-http-check"
"datadog-iis"
"datadog-istio"
"datadog-kafka"
"datadog-kafka-consumer"
"datadog-kong"
"datadog-kube-dns"
"datadog-kube-proxy"
"datadog-kubelet"
"datadog-kubernetes"
"datadog-kubernetes-state"
"datadog-kyototycoon"
"datadog-lighttpd"
"datadog-linkerd"
"datadog-linux-proc-extras"
"datadog-mapreduce"
"datadog-marathon"
"datadog-mcache"
"datadog-mesos-master"
"datadog-mesos-slave"
"datadog-mongo"
"datadog-mysql"
"datadog-nagios"
"datadog-network"
"datadog-nfsstat"
"datadog-nginx"
"datadog-ntp"
"datadog-openldap"
"datadog-openmetrics"
"datadog-openstack"
"datadog-oracle"
"datadog-pdh-check"
"datadog-pgbouncer"
"datadog-php-fpm"
"datadog-postfix"
"datadog-postgres"
"datadog-powerdns-recursor"
"datadog-process"
"datadog-prometheus"
"datadog-rabbitmq"
"datadog-redisdb"
"datadog-riak"
"datadog-riakcs"
"datadog-snmp"
"datadog-solr"
"datadog-spark"
"datadog-sqlserver"
"datadog-squid"
"datadog-ssh-check"
"datadog-statsd"
"datadog-supervisord"
"datadog-system-core"
"datadog-system-swap"
"datadog-tcp-check"
"datadog-teamcity"
"datadog-tokumx"
"datadog-tomcat"
"datadog-twemproxy"
"datadog-varnish"
"datadog-vault"
"datadog-vsphere"
"datadog-win32-event-log"
"datadog-windows-service"
"datadog-wmi-check"
"datadog-yarn"
"datadog-zk"
)

rm -f $LOG_FILE

integrations-core-downloader datadog-checks-base==4.2.0 

#for PACKAGE in "${PACKAGES[@]}"
#do
#  # TODO: support downloading packages without specifying version numbers
#  integrations-core-downloader $PACKAGE
#  test -f $REPOS_DIR/$REPO_DIR/targets/simple/$PACKAGE/*.whl
#  echo '' &>> $LOG_FILE
#done

# NOTE: Count that the number of interpositions should match double the number
# of known packages: one for the package simple index, and one for the package
# wheel itself.
#PACKAGES_LENGTH=${#PACKAGES[@]}
#DOUBLE_PACKAGES_LENGTH=$(($PACKAGES_LENGTH*2))
#PACKAGE_INTERCEPTIONS_LENGTH=$(grep ' matched ' $LOG_FILE | sort | uniq | wc -l)
#test $PACKAGE_INTERCEPTIONS_LENGTH -eq $DOUBLE_PACKAGES_LENGTH

rm -f *.tar.gz
rm -f *.whl
rm -f *.zip

deactivate
