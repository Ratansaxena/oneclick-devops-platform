provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "OneClick-DevOps-Platform"
      Environment = "dev"
      Owner       = "Ratan Saxena"
      ManagedBy   = "Terraform"
    }
  }
}