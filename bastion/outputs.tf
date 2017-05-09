output "bastion_public_ip" {
  value = "${module.bastion.bastion_public_ip}"
}

output "bastion_private_ip" {
  value = "${module.bastion.bastion_private_ip}"
}

