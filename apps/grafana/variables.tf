variable "env" {
  description = "environment"
}

variable "name" {
  description = "Name of the application"
  default     = "grafana"
}

variable "instance_port" {
  description = "Port number on the insance"
  default     = "6464"
}

variable "username" {
  description = "DB username"
}

variable "password" {
  description = "DB password"
}
