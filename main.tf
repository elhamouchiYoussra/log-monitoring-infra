terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}



module "log-monitoring" {
  source = "./models/log-monitoring"
  # Input Variables
  server_name      = "docker_host"
  environment_name = "dev"

}


provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
