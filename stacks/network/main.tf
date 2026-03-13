provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {}

variable "subnet_ids" {
  type = any
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "spacelift-eks"
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = tolist(var.subnet_ids)

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 1
      min_size     = 1

      instance_types = ["t3.small"]
    }
  }
}