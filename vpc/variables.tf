variable "env" {
  description = "The environment"
}

variable "name" {
  description = "Name of the VPC"
  default     = "masters-project"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
}

variable "public_subnets" {
  description = "CIDR list of public subnets"
  type        = "list"
}

variable "private_subnets" {
  description = "CIDR list of private subnets"
  type        = "list"
}
