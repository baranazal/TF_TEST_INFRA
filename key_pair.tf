# Generate a new key pair for EC2 instance access
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Register the public key with AWS
resource "aws_key_pair" "generated_key" {
  key_name   = "${var.project}-${var.environment}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = {
    Name        = "${var.project}-${var.environment}-key"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}

# Save private key to a local file
resource "local_file" "private_key_pem" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "ssh_keys/${var.project}-${var.environment}-key.pem"
  file_permission = "0600"

  # Create directory if it doesn't exist
  provisioner "local-exec" {
    command = "mkdir -p ssh_keys"
  }
}

# Output the generated private key
output "ssh_private_key" {
  description = "The generated private key for SSH access"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

# Output the key name for reference
output "ssh_key_name" {
  description = "Name of the generated SSH key"
  value       = aws_key_pair.generated_key.key_name
} 