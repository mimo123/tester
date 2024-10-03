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


provider "keycloak" {
}

resource "keycloak_realm" "realm" {
  realm   = "my-realm"
  enabled = true
}

resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.realm.id
  client_id           = "test-client"

  name                = "test client"
  enabled             = true

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = [
    "http://localhost:8080/openid-callback"
  ]

  login_theme = "keycloak"

  extra_config = {
    "key1" = "value1"
    "key2" = "value2"
  }
}
