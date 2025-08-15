provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  cluster_name         = var.cluster_name
}

module "eks" {
  source = "./modules/eks"
  
  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_group_name = "managed-nodes"
}

module "rds" {
  source = "./modules/rds"
  
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.eks.node_security_group_id]
  db_name            = "appdb"
  username           = "admin"
  password           = var.db_password
}
