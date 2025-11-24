variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets."
  type        = bool
  default     = true
}

variable "sg_ingress_cidr_blocks" {
  description = "The CIDR blocks for the security group ingress rules."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_egress_cidr_blocks" {
  description = "The CIDR blocks for the security group egress rules."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}
