provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "spacelift"
    workspaces = {
      name = "network-stack"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = "spacelift-eks"

  cluster_version = "1.29"

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  subnet_ids = [
    data.terraform_remote_state.network.outputs.subnet_id
  ]

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 1
      min_size     = 1

      instance_types = ["t3.small"]
    }
  }
}