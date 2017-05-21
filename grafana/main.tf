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
  name                  = "grafana"
  env                   = "${var.env}"
  vpc                   = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets               = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
  instance_port         = "${var.instance_port}"
  health_check_target   = "/login"
  container_port        = 3000
  ecs_cluster           = "${data.terraform_remote_state.ecs.ecs_cluster}"
  container_definitions = "${file("files/grafana-task-definition.json")}"
}
