# module "eks" {
#   source = "./modules/eks"

#   cluster_name = local.names.eks
#   subnet_ids   = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
#   tags         = local.common_tags

#   instance_type    = "t3.medium"
#   desired_capacity = 3
#   max_size         = 5
#   min_size         = 2

#   addons = {
#     "vpc-cni"    = { version = null }
#     "coredns"    = { version = null }
#     "kube-proxy" = { version = null }
#   }
# }
