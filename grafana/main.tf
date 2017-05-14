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
  subnets               = "${data.terraform_remote_state.vpc.public_subnet_ids}"
  security_groups       = "${data.terraform_remote_state.ecs.ecs_security_group}"
  instance_port         = 6464
  health_check_target    = "/"
  container_port        = 3000
  ecs_cluster           = "${data.terraform_remote_state.ecs.ecs_cluster}"
  container_definitions = "${file("files/grafana-task-definition.json")}"
}
