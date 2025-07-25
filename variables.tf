variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "openshift"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}

variable "bastion_public_key" {
  description = "The public key for the bastion host."
  type        = string
  sensitive   = true
}
