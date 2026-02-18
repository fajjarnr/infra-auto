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
  default     = "1.33"
}

variable "endpoint_private_access" {
  description = "Enable private API server endpoint."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public API server endpoint."
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks that can access the public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enabled_cluster_log_types" {
  description = "List of control plane logging types to enable."
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "kms_key_arn" {
  description = "ARN of KMS key for secrets encryption. If not provided, uses AWS managed key."
  type        = string
  default     = ""
}

variable "addons" {
  description = "Map of EKS addon configurations keyed by addon name. Set version to null to track the latest."
  type = map(object({
    version                     = optional(string)
    resolve_conflicts_on_update = optional(string)
  }))
  default = {
    "vpc-cni"    = {}
    "coredns"    = {}
    "kube-proxy" = {}
  }
}

variable "node_disk_size" {
  description = "Disk size in GB for worker nodes."
  type        = number
  default     = 20
}

variable "node_labels" {
  description = "Key-value map of Kubernetes labels for nodes."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}
