provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source          = "git@github.com:tatusl/masters-project-terraform-modules.git//vpc"
  name            = "${var.name}"
  env             = "${var.env}"
  cidr            = "${var.vpc_cidr}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"
}
