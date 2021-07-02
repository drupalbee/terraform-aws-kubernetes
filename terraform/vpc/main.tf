module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = var.project_name
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb"                   = "1"
    "kubernetes.io/cluster/${var.project_name}" = "shared"
    Public                                     = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"          = "1"
    "kubernetes.io/cluster/${var.project_name}" = "shared"
    Private                                    = "1"
  }

  tags = {
    Terraform = "true"
  }
}
