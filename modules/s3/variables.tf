variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Boolean that indicates whether the bucket can be destroyed when not empty"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name (e.g. dev, prod, staging)"
  type        = string
}

variable "project" {
  description = "Project name for resource tagging"
  type        = string
} 