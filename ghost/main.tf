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

data "terraform_remote_state" "ecs" {
  backend = "s3"

  config {
    bucket = "mp-remote-state"
    key    = "ecs/state/${var.env}"
    region = "eu-west-1"
  }
}

module "application" {
  source                = "git@github.com:tatusl/masters-project-terraform-modules.git//application"
  name                  = "ghost"
  env                   = "${var.env}"
  image                 = "library/ghost:alpine"
  memory_limit          = 512
  vpc                   = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets               = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
  instance_port         = "${var.instance_port}"
  health_check_target   = "/"
  container_port        = 2368
  ecs_cluster           = "${data.terraform_remote_state.ecs.ecs_cluster}"
}
