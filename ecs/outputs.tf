output "ecs_cluster" {
  value = "${module.ecs.ecs_cluster}"
}

output "ecs_security_group" {
  value = "${module.ecs.ecs_security_group}"
}
