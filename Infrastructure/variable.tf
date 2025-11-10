variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "project" {
  type    = string
  default = "jobfinder"
}

variable "env" {
  type    = string
  default = "prod"
}

variable "db_username" {
  type    = string
  default = "appuser"
}

variable "db_password" {
  description = "Strong DB password (sensitive)"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_instance_class" {
  description = "Free-tier friendly: db.t2.micro (if available in account)"
  type    = string
  default = "db.t2.micro"
}

# ECR image tags will be set from CI (so we just create repos)
variable "frontend_ecr" {
  type    = string
  default = "jobfinder-frontend"
}
variable "backend_ecr" {
  type    = string
  default = "jobfinder-backend"
}
