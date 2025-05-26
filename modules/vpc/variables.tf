variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (e.g. dev, prod, staging)"
  type        = string
}

variable "project" {
  description = "Project name for resource tagging"
  type        = string
} 