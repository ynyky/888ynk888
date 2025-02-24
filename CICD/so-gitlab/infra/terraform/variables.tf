variable "ssh_pub" {
  description = "SSH public key to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID for EC2 instances"
  type        = string
  default     = "ami-03cc8375791cb8bcf"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "ssh_ingress_port" {
  description = "Port to allow SSH access"
  type        = number
  default     = 22
}

variable "http_ingress_port" {
  description = "Port to allow HTTP access"
  type        = number
  default     = 8081
}

variable "instance_name_staging" {
  description = "Name tag for the staging EC2 instance"
  type        = string
  default     = "mj"
}

variable "instance_name_production" {
  description = "Name tag for the production EC2 instance"
  type        = string
  default     = "mj-instance-2"
}

variable "environment_staging" {
  description = "Environment tag for the staging instance"
  type        = string
  default     = "staging"
}

variable "environment_production" {
  description = "Environment tag for the production instance"
  type        = string
  default     = "production"
}
variable "bucket_name" {
  type = string
  description = "Name for the S3 bucket"
}

variable "dynamodb_table_name" {
  type = string
  description = "Name for the DynamoDB table"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}