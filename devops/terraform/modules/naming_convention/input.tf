variable "type" {
  description = "resource type short name"
  # Based on https://hilo9392qc.atlassian.net/wiki/spaces/HILO/pages/471629861/Naming+convention+des+ressources+Azure, and
  # https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming
  #Resource group : rg
  #Keyvaul : kv
  #application insight:appi
  #database:db
  #sql database: sql
  type = string
}

variable "name" {
  description = "service name"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

variable "instance" {
  description = "alphanumeric environment suffix (ex: the \"01\" in app-project-dev-01, or \"claude\" in kv-project-qa-claude"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-z]+$", var.instance))
    error_message = "Argument \"instance\" must be alphanumerical and lowercase."
  }

}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}