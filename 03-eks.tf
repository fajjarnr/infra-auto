module "eks" {
  source = "./modules/eks"

  cluster_name = "my-eks-cluster"
  subnet_ids   = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)

  instance_type    = "t3.medium"
  desired_capacity = 3
  max_size         = 5
  min_size         = 2
}
