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

module "bastion" {
  source        = "git@github.com:tatusl/masters-project-terraform-modules.git//bastion"
  env           = "${var.env}"
  key_name      = "${data.terraform_remote_state.account.account_key}"
  vpc_id        = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_id     = "${data.terraform_remote_state.vpc.public_subnet_ids[0]}"
  allowed_hosts = "${var.allowed_hosts}"
}
