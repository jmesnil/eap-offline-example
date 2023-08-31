mvn -s local-eap-settings.xml clean package
podman build  --tls-verify=false --platform  linux/amd64 -t eap8-ga-app .