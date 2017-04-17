provider "aws" {
  region = "eu-west-1"
}

module "account" {
  source       = "git@github.com:tatusl/masters-project-terraform-modules.git//account"
  key_name     = "masters-project-${var.env}"
  pub_key_file = "${file("files/maspro_${var.env}.pub")}"
}
