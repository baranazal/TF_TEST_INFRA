module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  environment         = var.environment
  project             = var.project
}

module "ec2" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  key_name      = aws_key_pair.generated_key.key_name
  environment   = var.environment
  project       = var.project
}

module "s3" {
  source = "./modules/s3"

  bucket_name   = var.bucket_name
  force_destroy = var.force_destroy
  environment   = var.environment
  project       = var.project
}

# Create an Elastic IP for the EC2 instance
resource "aws_eip" "instance_eip" {
  instance = module.ec2.instance_id
  domain   = "vpc"

  tags = {
    Name        = "${var.project}-${var.environment}-eip"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
} 