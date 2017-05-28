output "hosted_zone_id" {
  value = "${aws_route53_zone.aws_tatusl.zone_id}"
}

output "name_servers" {
  value = "${aws_route53_zone.aws_tatusl.name_servers}"
}
