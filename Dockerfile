FROM registry.redhat.io/jboss-eap-8-tech-preview/eap8-openjdk17-runtime-openshift-rhel8:latest
COPY --chown=jboss:root target/server $JBOSS_HOME
RUN chmod -R ug+rwX $JBOSS_HOME

