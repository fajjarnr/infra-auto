variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets for the EKS cluster."
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type for the EKS node group."
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "The desired number of nodes in the EKS node group."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of nodes in the EKS node group."
  type        = number
  default     = 3
}

variable "min_size" {
  description = "The minimum number of nodes in the EKS node group."
  type        = number
  default     = 1
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.30"
}
