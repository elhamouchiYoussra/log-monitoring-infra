variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-2"
}

variable "server_name" {
  description = "server name"
  type        = string
  default     = "server"
}


variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = "dev"
}

variable "protocol" {
  description = "Deployment protocol"
  type        = string
  default     = "tcp"
}

variable "port" {
  description = "from port"
  type        = string
}



variable "private_ip" {
  description = "private_ip"
  type        = string
}