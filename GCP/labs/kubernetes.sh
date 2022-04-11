#!/bin/bash
gcloud container clusters create test --zone us-east1-b

##
kubectl create deployment hello-app --image=gcr.io/google-samples/hello-app:2.0

##expose 
kubectl expose deployment hello-app --type=LoadBalancer --port 8080