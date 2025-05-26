variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
  
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "The aws_region value must be a valid AWS region format, e.g., eu-central-1."
  }
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
  default     = "bara"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod, staging)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be one of: dev, staging, prod."
  }
}

variable "project" {
  description = "Project name for resource tagging"
  type        = string
  default     = "bara"
}

# VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "The vpc_cidr value must be a valid CIDR notation."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# EC2 Variables
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0a87a69d69fa289be"
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
  default     = null
}

# S3 Variables
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "bara-digi-bucket"
  
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "The bucket name must be between 3 and 63 characters, and can only contain lowercase letters, numbers, hyphens, and periods."
  }
}

variable "force_destroy" {
  description = "Boolean that indicates whether the bucket can be destroyed when not empty"
  type        = bool
  default     = true
} 

variable "ssh_public_keys" {
  description = "List of SSH public keys to be added to authorized_keys file"
  type        = list(string)
  default     = []
} 