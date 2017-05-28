provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "aws_tatusl" {
  name = "aws.tatusl.eu"
}
