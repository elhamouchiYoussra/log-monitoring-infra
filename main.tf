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



module "docker" {
  source = "./models/instance"
  # Input Variables
  server_name      = "docker_host"
  environment_name = "dev"
  port             = 9000
  private_ip       = "10.0.1.51"

}




module "jenkins" {
  source = "./models/instance"
  # Input Variables
  server_name      = "jenkins_server"
  environment_name = "dev"
  port             = 8080
  private_ip       = "10.0.1.52"

}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
