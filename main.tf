terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend

 

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}



module "log-monitoring" {
  source = "./models/log-monatoring"
  # Input Variables
  server_name      = "docker_host"
  environment_name = "dev"

}


provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
