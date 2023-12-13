provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "kubernetes.io/cluster/demo-eks" = "owned"
    }
  }
}