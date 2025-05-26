variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script for EC2 instance initialization"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name (e.g. dev, prod, staging)"
  type        = string
}

variable "project" {
  description = "Project name for resource tagging"
  type        = string
} 