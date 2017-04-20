provider "aws" {
  region = "eu-west-1"
}

module "state_bucket" {
  source      = "git@github.com:tatusl/masters-project-terraform-modules.git//state_bucket"
  bucket_name = "mp-remote-state"
}
