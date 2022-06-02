#!/bin/bash

EAP_MAVEN_REPO=${1}

cp ./maven-metadata.xml ${EAP_MAVEN_REPO}/org/jboss/eap/wildfly-ee-galleon-pack/
cd ${EAP_MAVEN_REPO}/org/jboss/eap/wildfly-ee-galleon-pack
EAP_VERSION=$(find * -maxdepth 0 -type d)

sed -i "" -e "s|<!-- ##EAP_VERSION## -->|${EAP_VERSION}|" ./maven-metadata.xml
SHA1SUM=$(shasum ./maven-metadata.xml  | cut -d " " -f1)
echo $SHA1SUM > maven-metadata.xml.sha1

echo "=========="
echo " Added ${EAP_VERSION} to the maven-metadata.xml for org.jboss.eap:wildfly-ee-galleon-pack"
echo " in Maven repository ${EAP_MAVEN_REPO}"
echo "=========="
