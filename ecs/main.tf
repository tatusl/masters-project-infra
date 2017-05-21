provider "aws" {
  region = "eu-west-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "mp-remote-state"
    key    = "vpc/state/${var.env}"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "account" {
  backend = "s3"

  config {
    bucket = "mp-remote-state"
    key    = "account/state/${var.env}"
    region = "eu-west-1"
  }
}

data "terraform_remote_state" "bastion" {
  backend = "s3"

  config {
    bucket = "mp-remote-state"
    key    = "bastion/state/${var.env}"
    region = "eu-west-1"
  }
}

module "ecs" {
  source        = "git@github.com:tatusl/masters-project-terraform-modules.git//ecs"
  name          = "${var.name}"
  env           = "${var.env}"
  vpc           = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets       = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]
  keypair_name  = "${data.terraform_remote_state.account.account_key}"
  allowed_hosts = "${data.terraform_remote_state.bastion.bastion_private_ip}/32"
}

resource "aws_security_group_rule" "allow_request_from_vpc" {
  security_group_id = "${module.ecs.ecs_security_group}"
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${data.terraform_remote_state.vpc.vpc_cidr}"]
}
