output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.instance_eip.public_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "bucket_name" {
  description = "ID of the S3 bucket"
  value       = module.s3.bucket_id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "terraform_state_bucket" {
  description = "Name of the S3 bucket used for Terraform state storage"
  value       = aws_s3_bucket.terraform_state.id
}

output "terraform_state_lock_table" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "ssh_private_key_path" {
  description = "Path to the generated SSH private key file"
  value       = "The private key has been saved to: ssh_keys/${var.project}-${var.environment}-key.pem"
}

output "ssh_connection_command" {
  description = "Command to connect to the EC2 instance using SSH"
  value       = "ssh -i ssh_keys/${var.project}-${var.environment}-key.pem ubuntu@${aws_eip.instance_eip.public_ip}"
}

output "friend_connection_instructions" {
  description = "to connect to the EC2 instance"
  value       = "Full Instance Details:\nInstance ID: ${module.ec2.instance_id}\nPublic IP: ${aws_eip.instance_eip.public_ip}\nSSH Command: ssh -i ${var.project}-${var.environment}-key.pem ubuntu@${aws_eip.instance_eip.public_ip}\n\nImportant: Share the private key file (${var.project}-${var.environment}-key.pem) securely."
} 