module "vpc" {
  source   = "../../modules/vpc"
  name     = "dev"
  vpc_cidr = "10.1.0.0/16"
  azs      = ["ap-south-1a", "ap-south-1b"]
}

module "iam" {
  source = "../../modules/iam"
  name   = "dev"
}

module "eks" {
  source             = "../../modules/eks"
  name               = "dev-eks"
  cluster_role_arn   = module.iam.cluster_role_arn
  node_role_arn      = module.iam.node_role_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  k8s_version        = "1.29"

  desired_size   = 2
  min_size       = 2
  max_size       = 3
  instance_types = ["t3.medium"]
}

output "cluster_name" {
  value = module.eks.cluster_name
}
