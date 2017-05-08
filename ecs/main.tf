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

module "ecs" {
  source       = "git@github.com:tatusl/masters-project-terraform-modules.git//ecs"
  name         = "${var.name}"
  env          = "${var.env}"
  vpc          = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets      = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]
  keypair_name = "${data.terraform_remote_state.account.account_key}"
}
