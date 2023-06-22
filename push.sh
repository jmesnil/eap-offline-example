oc registry login
export OC_REGISTRY=$(oc registry info)
OC_IMAGESTREAM=$OC_REGISTRY/$(oc project -q)/eap8-ga-app
docker tag eap8-ga-app $OC_IMAGESTREAM
docker push $OC_IMAGESTREAM
oc set image-lookup eap8-ga-app