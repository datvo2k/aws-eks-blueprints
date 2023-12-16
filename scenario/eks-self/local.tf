locals {
  name            = "ex-${replace(basename(path.cwd), "_", "-")}"
  cluster_version = "1.27"
  region          = var.region

  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  owners      = var.business_divsion
  environment = var.environment

  aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
  tags = {
    Example = local.name
  }
}
