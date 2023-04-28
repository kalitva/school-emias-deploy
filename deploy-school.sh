#!/bin/bash

EMIAS_SCHOOL_SRC=
DESTINATION=$PWD

function log {
  echo -e "\033[32m$1\e[0m"
}

function log_error {
  echo -e "\033[31m$1\e[0m"
}

function clean_and_exit {
 rm -rf wildfly-10.1.0.Final*
 exit
}

if [[ -z "$EMIAS_SCHOOL_SRC" ]]; then
  log_error 'please set $EMIAS_SCHOOL_SRC'
  exit
fi

cd $DESTINATION

log 'downloading and extracting wildfly server'
wget https://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz || exit
tar xzvf wildfly-10.1.0.Final.tar.gz || exit

log 'copying standalone.conf and standalone.xml'
cp resources/standalone.conf wildfly-10.1.0.Final/bin/
cp resources/standalone.xml wildfly-10.1.0.Final/standalone/configuration/

log 'setting oracle module'
cp -r resources/com/ wildfly-10.1.0.Final/modules/

log 'setting jackson lib'
rm -rf wildfly-10.1.0.Final/modules/system/layers/base/com/fasterxml/jackson/
cp -r resources/jackson wildfly-10.1.0.Final/modules/system/layers/base/com/fasterxml/

log 'building and deploying war'
cd $EMIAS_SCHOOL_SRC
mvn clean install || (log_error 'build failure' && clean_and_exit)
cd $DESTINATION
cp $EMIAS_SCHOOL_SRC/school-service/target/school-service.war wildfly-10.1.0.Final/standalone/deployments/

log 'executing migrations'
cd $EMIAS_SCHOOL_SRC/school-service
mvn -P migration liquibase:update \
-DskipTests=true \
-Dliquibase.driver=oracle.jdbc.driver.OracleDriver \
-Dliquibase.changeLogFile=src/main/resources/oracle/master_init.xml \
-Dliquibase.url=jdbc:oracle:thin:@//localhost:1521/orcl \
-Dliquibase.username=EMIAS_SCHOOL \
-Dliquibase.password=EMIAS_SCHOOL \
-Dliquibase.verbose=true \
-Dliquibase.dropFirst=false || (log_error 'build failure' && clean_and_exit)
