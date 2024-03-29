#
# Variables Configuration
#

variable "customer_name" {
  description = "Customer name"
  type    = string
}

variable "cluster_name" {
  description = "Name of cluster"
  type    = string
}

variable "cluster_version" {
  description = "Kubernetes version to deploy"
  default = "1.24"
  type    = string
}

variable "region" {
  description = "AWS region to launch servers"
  type    = string
  default = "us-east-1"
}

variable "instance_class" {
  description = "machine type to be used"
  type    = string
  default = "t3.2xlarge"
}

variable "autoscaling_options" {
  description = "Range for autoscaling of worker nodes"
  type        = map(string)
  default     = {
    desired_size = 8
    min_size = 1
    max_size = 10
  }
}
