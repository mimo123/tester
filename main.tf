terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 4.0.0"
    }
  }

  backend "remote" {
    hostname = "testjfrogma.jfrog.io"
    organization = "test"
    workspaces {
      prefix = "my-prefix-"
    }
  }
}


provider "keycloak" {
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

resource "keycloak_realm" "realm" {
  realm   = "my-realm"
  enabled = true
}

resource "keycloak_openid_client" "openid_client" {
  realm_id            = keycloak_realm.realm.id
  client_id           = "test-client"

  name                = "test client"
  standard_flow_enabled = true  # Enables Authorization Code Flow

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = [
    "http://localhost:8080/openid-callback"
  ]

}


resource "keycloak_role" "client_role_a" {
  realm_id    = keycloak_realm.realm.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "my-client-roleA"
  description = "My Client RoleA"
}


resource "keycloak_role" "client_role_B" {
  realm_id    = keycloak_realm.realm.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = "my-client-roleB"
  description = "My Client RoleB"
}

