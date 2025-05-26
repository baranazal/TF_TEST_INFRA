resource "aws_security_group" "instance" {
  name        = "${var.project}-${var.environment}-sg"
  description = "Security group for ${var.project} ${var.environment} EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-sg"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = var.key_name
  user_data              = var.user_data

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    encrypted   = true
  }

  tags = {
    Name        = "${var.project}-${var.environment}-instance"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
} 