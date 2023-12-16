// ----------------------------------------------------------------------------
// Config SSM login to bastion host
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Config SSH key login to bastion host
// ----------------------------------------------------------------------------
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.0.0"

  name                   = "${local.name}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags                   = local.common_tags
}

module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name        = "${local.name}-public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"

  vpc_id = module.vpc.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}

resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_public, module.vpc]
  instance   = module.ec2_public.id
  tags       = local.common_tags
}
