variable "env" {
  description = "environment"
}

variable "allowed_hosts" {
  description = "CIDR block of allowed hosts"
  default     = ["84.249.208.176/32"]
}
