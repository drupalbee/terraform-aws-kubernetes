data "aws_vpc" "vpc" {
  tags = {
    "Project" = var.project_name
  }
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Private = "1"
  }
}

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "14.0.0"

  cluster_name    = var.project_name
  cluster_version = "1.19"
  manage_aws_auth = true

  subnets = data.aws_subnet_ids.subnet_ids.ids
  vpc_id  = data.aws_vpc.vpc.id

  cluster_endpoint_private_access = true

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 32
  }

  node_groups = {
    on-demand = {
      desired_capacity = var.node_group_on_demand_desired_capacity
      min_capacity     = var.node_group_on_demand_min_capacity
      max_capacity     = var.node_group_on_demand_max_capacity

      instance_types = var.node_group_on_demand_instance_types
      capacity_type  = var.node_group_on_demand_capacity_type
    }

  }

  tags = {
    Terraform                                       = "true"
    "k8s.io/cluster-autoscaler/${var.project_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = "TRUE"
  }

  map_users = var.map_users
}
