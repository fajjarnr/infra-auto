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

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block (e.g., 10.0.0.0/16)."
  }
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]

  validation {
    condition     = length(var.public_subnet_cidrs) > 0 && alltrue([for c in var.public_subnet_cidrs : can(cidrnetmask(c))])
    error_message = "public_subnet_cidrs must be a non-empty list of valid CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]

  validation {
    condition     = length(var.private_subnet_cidrs) > 0 && alltrue([for c in var.private_subnet_cidrs : can(cidrnetmask(c))])
    error_message = "private_subnet_cidrs must be a non-empty list of valid CIDR blocks."
  }
}

variable "bastion_public_key" {
  description = "The public key for the bastion host."
  type        = string
  sensitive   = true
}

variable "default_tags" {
  description = "Default tags to apply to all supported AWS resources."
  type        = map(string)
  default     = {}
}
