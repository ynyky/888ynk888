#!/bin/bash
##Create a managed instance group based on the template:

gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-east1-b

##Create the fw-allow-health-check firewall rule. This is an ingress rule that allows traffic from the Google Cloud health checking systems (130.211.0.0/22 and 35.191.0.0/16). This lab uses the target tag allow-health-check to identify the VMs.

gcloud compute firewall-rules create fw-allow-health-check \
    --network=default \
    --action=allow \
    --direction=ingress \
    --source-ranges=130.211.0.0/22,35.191.0.0/16 \
    --target-tags=allow-health-check \
    --rules=tcp:80

##Now that the instances are up and running, set up a global static external IP address that your customers use to reach your load balancer.

gcloud compute addresses create lb-ipv4-1 \
    --ip-version=IPV4 \
    --global

##Note the IPv4 address that was reserved:

gcloud compute addresses describe lb-ipv4-1 \
    --format="get(address)" \
    --global
####34.95.65.252###

##Create a healthcheck for the load balancer:

gcloud compute health-checks create http http-basic-check \
    --port 80

##Create a backend service:

gcloud compute backend-services create web-backend-service \
    --protocol=HTTP \
    --port-name=http \
    --health-checks=http-basic-check \
    --global

##Add your instance group as the backend to the backend service:

gcloud compute backend-services add-backend web-backend-service \
    --instance-group=lb-backend-group \
    --instance-group-zone=us-east1-b \
    --global

##Create a URL map to route the incoming requests to the default backend service:

gcloud compute url-maps create web-map-http \
    --default-service web-backend-service

##Create a target HTTP proxy to route requests to your URL map:
gcloud compute target-http-proxies create http-lb-proxy \
        --url-map web-map-http

##Create a global forwarding rule to route incoming requests to the proxy:

gcloud compute forwarding-rules create http-content-rule \
        --address=lb-ipv4-1\
        --global \
        --target-http-proxy=http-lb-proxy \
        --ports=80