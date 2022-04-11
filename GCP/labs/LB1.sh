
##Create a static external IP address for your load balancer:

gcloud compute addresses create network-lb-ip-1 \
 --region us-east1

 ##Add a legacy HTTP health check resource:

gcloud compute http-health-checks create basic-check

##Add a target pool in the same region as your instances. Run the following to create the target pool and use the health check, which is required for the service to function:

gcloud compute target-pools create www-pool \
    --region us-east1 --http-health-check basic-check

##Add the instances to the pool:

gcloud compute target-pools add-instances www-pool \
    --instances www1,www2 --zone us-east1-b

##Add a forwarding rule:

gcloud compute forwarding-rules create www-rule \
    --region us-east1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool

##Enter the following command to view the external IP address of the www-rule forwarding rule used by the load balancer:

gcloud compute forwarding-rules describe www-rule --region us-east1