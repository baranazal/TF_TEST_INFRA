# This file is initially commented out. After applying the terraform_state bucket,
# you should uncomment this section and run terraform init again to migrate the state.


terraform {
  backend "s3" {
    bucket         = "bara-terraform-state-dev"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "bara-terraform-locks-dev"
    encrypt        = true
  }
}


# Instructions:
# 1. First apply with local state: terraform apply -var-file=dev.tfvars
# 2. After the state bucket is created, uncomment the backend configuration above
# 3. Run terraform init to migrate your state to S3
# 4. Your state is now stored remotely in S3 with locking in DynamoDB 