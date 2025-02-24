# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "project_id" {
  description = "Google Cloud Project ID"
  default = "analog-pilot-422817-r3"
}

variable "region" {
  description = "GCP Region"
  default     = "europe-central2"
}
variable "cluster_name" {
  description = "Name of the GKE cluster"
  default     = "my-gke-cluster"
}
variable "machine_type" {
  description = "Machine type for nodes"
  default     = "n1-standard-1"
}
variable "disk_size_gb" {
  description = "Disk size for nodes (in GB)"
  default     = 10
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  default     = 1
}
variable "credentials_file_path" {
  default = "../analog-pilot-422817-r3-8072da3e975e.json"
}