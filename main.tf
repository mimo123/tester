# main.tf
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}




# Define a local variable
locals {
  environment = "development"
  owner       = "team-ABC"
}

# Output the local variable values
output "environment" {
  description = "The current environment"
  value       = local.environment
}

output "owner" {
  description = "The owner of the infrastructure"
  value       = local.owner
}
