data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = var.bucket_name
    key    = var.key_tfstate
    region = var.aws_region
  }
}
