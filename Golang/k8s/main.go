package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
)

type Secret struct {
	APIVersion string `json:"apiVersion"`
	Kind       string `json:"kind"`
	Metadata   struct {
		Namespace string `json:"namespace"`
		Name      string `json:"name"`
	} `json:"metadata"`
	Labels struct {
		App   string `json:"app"`
		Cloud string `json:"cloud"`
	} `json:"labels"`
	Data struct {
		DockerConfigJson string `json:".dockerconfigjson"`
	} `json:"data"`
	Type string `json:"type"`
}

func main() {
	secret := Secret{
		APIVersion: "v1",
		Kind:       "Secret",
	}

	secret.Metadata.Namespace = "<namespace>" // replace with the actual namespace
	secret.Metadata.Name = "<secret_name>"    // replace with the actual secret name
	secret.Labels.App = "registry-creds"
	secret.Labels.Cloud = "ecr"
	secret.Data.DockerConfigJson = "<token>" // replace with the actual token (base64 encoded)
	secret.Type = "kubernetes.io/dockerconfigjson"

	// Convert struct to JSON
	secretJSON, err := json.MarshalIndent(secret, "", "  ")
	if err != nil {
		log.Fatalf("Error marshalling JSON: %v", err)
	}

	// Print the resulting JSON
	fmt.Println(string(secretJSON))
	config, err := rest.InClusterConfig()
	if err != nil {
		log.Fatalf("Error loading in-cluster config: %s", err.Error())
	}

	// Create the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		log.Fatalf("Error creating clientset: %s", err.Error())
	}

	// List all pods in the default namespace
	pods, err := clientset.CoreV1().Pods("default").List(context.TODO(), metav1.ListOptions{})
	if err != nil {
		log.Fatalf("Error listing pods: %s", err.Error())
	}

	// Print the pod names
	fmt.Println("Pods in default namespace:")
	for _, pod := range pods.Items {
		fmt.Println(pod.Name)
	}

}
