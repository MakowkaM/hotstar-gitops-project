terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0"
    }
  }

  backend "s3" {
    bucket = "hotstar-bucket-backend-2"
    key    = "ecr/terraform.tfstate"
    region = "eu-central-1"
  }

  required_version = ">= 1.6.3"
}
