FROM registry-proxy.engineering.redhat.com/rh-osbs/jboss-eap-8-eap8-openjdk17-runtime-openshift-rhel8:jb-eap-8.0-rhel-8-containers-candidate-79002-20230516072620
COPY --chown=jboss:root target/server $JBOSS_HOME
RUN chmod -R ug+rwX $JBOSS_HOME