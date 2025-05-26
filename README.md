# Terraform Infrastructure

This repository contains Terraform configuration for provisioning and managing AWS infrastructure in a modular, maintainable way.

## Infrastructure Overview

This project provisions:
- VPC with multiple availability zones
- Public subnets with internet access
- EC2 instance with security groups
- S3 bucket with proper access controls
- Remote state management with S3 and DynamoDB

## Project Structure

```
.
├── main.tf                 # Main orchestration file
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values
├── provider.tf             # Provider configuration
├── state_bucket.tf         # Terraform state storage configuration
├── backend.tf              # S3 backend configuration
├── key_pair.tf             # SSH key pair generation and management
├── dev.tfvars              # Development environment variables
├── .gitignore              # Git ignore file
├── modules/                # Reusable modules
│   ├── vpc/                # VPC infrastructure
│   │   ├── main.tf         # VPC resources definition
│   │   ├── variables.tf    # VPC module variables
│   │   └── outputs.tf      # VPC module outputs
│   ├── ec2/                # Compute resources
│   │   ├── main.tf         # EC2 resources definition
│   │   ├── variables.tf    # EC2 module variables
│   │   └── outputs.tf      # EC2 module outputs
│   └── s3/                 # Storage resources
│       ├── main.tf         # S3 resources definition
│       ├── variables.tf    # S3 module variables
│       └── outputs.tf      # S3 module outputs
└── README.md               # This documentation
```

## Requirements

- Terraform >= 1.2.0
- AWS CLI configured with appropriate credentials
- IAM permissions for creating VPC, EC2, S3, and DynamoDB resources

## Usage

### Initialize the project
```bash
terraform init
```

### Deploy the infrastructure
```bash
terraform apply -var-file=dev.tfvars
```

### Migrate to remote state
After the initial deployment:
1. Uncomment the backend configuration in `backend.tf`
2. Run `terraform init` and confirm migration when prompted

## Architecture

### Network Design
- VPC with CIDR 10.0.0.0/16
- Two public subnets across different availability zones
- Internet gateway for public internet access
- Route tables with appropriate routes

### Compute Resources
- EC2 instance in the first public subnet
- Security groups allowing SSH, HTTP, and HTTPS
- Encrypted root volume
- Tagged for proper resource management

### Storage
- S3 bucket with versioning
- Public access blocks for security
- Proper bucket ownership controls

### Remote State
- Dedicated S3 bucket for state storage
- Versioning and encryption enabled
- DynamoDB table for state locking

## Understanding Terraform Modules

### What are Modules?

Modules in Terraform are reusable, self-contained packages of Terraform configurations that manage a specific piece of infrastructure. Think of modules as functions in programming - they accept inputs (variables), create resources, and return outputs.

Each module in this project consists of:
- `main.tf`: Contains the resource definitions
- `variables.tf`: Defines input parameters
- `outputs.tf`: Specifies values to export for use by other configurations

### Why We Use Modules

1. **Reusability**: Write infrastructure code once and reuse it across multiple environments or projects.

2. **Abstraction**: Hide complex resource configurations behind a simple interface. For example, our VPC module handles subnet creation, routing tables, and internet gateway configurations, but users only need to provide CIDR blocks.

3. **Consistency**: Ensure all infrastructure follows the same patterns and best practices. Every EC2 instance created through our module has the same security baseline.

4. **Maintainability**: When you need to update a component (e.g., add a new security rule), you only need to change it in one place.

5. **Organization**: Modules create logical boundaries between different parts of infrastructure, making the codebase easier to understand and navigate.

### Modules in this Project

- **VPC Module**: Manages networking infrastructure including VPC, subnets, internet gateway, and routing.

- **EC2 Module**: Handles compute resources including the EC2 instance, security groups, and associated configurations.

- **S3 Module**: Provisions storage resources with appropriate security settings and access controls.

By using modules, this project creates a clean separation of concerns and allows each infrastructure component to be developed and modified independently while maintaining consistency across the entire architecture.

## SSH Access Configuration

### Automatically Generated SSH Keys

This project automatically generates an SSH key pair for accessing EC2 instances:

1. When you run `terraform apply`, a new RSA key pair is generated:
   ```bash
   terraform apply -var-file=dev.tfvars
   ```

2. The private key is saved locally to `ssh_keys/<project>-<environment>-key.pem` 
   with secure permissions (0600).

3. Connect to your instance using the generated key:
   ```bash
   ssh -i ssh_keys/<project>-<environment>-key.pem ubuntu@<instance_public_ip>
   ```