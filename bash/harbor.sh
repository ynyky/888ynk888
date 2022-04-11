#!/bin/bash
IMAGE_TAG='nightly-tfs'
cos=$(curl -X 'GET' \
                "https:/sds,com/api/v2.0/projects/tungstenfabric/repositories/contrail-vrouter-plugin-n3000-init-redhat/artifacts/$IMAGE_TAG/tags?with_signature=true&with_immutable_status=false" \
		-H 'accept: application/json' | grep error)
echo $cos
if [[ -z $cos ]];
then
	echo "nie ma"
else
	echo "mamy to"
fi
