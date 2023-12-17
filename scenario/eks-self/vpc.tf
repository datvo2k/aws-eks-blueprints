data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = local.name
  cidr = var.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  # intra_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 56)]

  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/role/elb"              = 1
    "kubernetes.io/cluster/${local.name}" = "shared"
  }

  private_subnet_tags = {
    Type                                  = "private-subnets"
    "kubernetes.io/role/internal-elb"     = 1
    "kubernetes.io/cluster/${local.name}" = "shared"
  }

  vpc_tags = local.common_tags
  tags     = local.tags
}
