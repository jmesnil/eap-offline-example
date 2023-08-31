# Use EAP 8 Builder image to create a JBoss EAP 8 server with its default configuration
FROM registry.redhat.io/jboss-eap-8-tech-preview/eap8-openjdk17-builder-openshift-rhel8:latest AS builder
# With these 3 environments variables, a JBoss EAP 8 server is provisioned with the "same"
# cloud configuration that EAP 7.4 standalone-openshift.xml
ENV GALLEON_PROVISION_FEATURE_PACKS org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack
ENV GALLEON_PROVISION_LAYERS cloud-default-config
ENV GALLEON_PROVISION_CHANNELS org.jboss.eap.channels:eap-8.0-beta
RUN /usr/local/s2i/assemble

# Copy the JBoss EAP 8 server from the previous step into the runtime image
# then the workflow is similar than with EAP 7.4
FROM registry.redhat.io/jboss-eap-8-tech-preview/eap8-openjdk17-runtime-openshift-rhel8:latest AS runtime
COPY --from=builder --chown=jboss:root $JBOSS_HOME $JBOSS_HOME

##############################################################
# Steps to add:                                                                                    
# (1) COPY the WAR/EAR to $JBOSS_HOME/standalone/deployments
#       with the jboss:root user. For example:
#     COPY --chown=jboss:root my-app.war $JBOSS_HOME/standalone/deployments

COPY --chown=jboss:root target/eap-offline-example.war $JBOSS_HOME/standalone/deployments

RUN $JBOSS_HOME/bin/jboss-cli.sh --commands "embed-server,/system-property=Foo:add(value=Bar)"

# (2)  modify the 
#       $JBOSS_HOME/standalone/configuration/standalone.xml
#       (not standalone-openshift.xml)
#
#############################################################

RUN chmod -R ug+rwX $JBOSS_HOME
