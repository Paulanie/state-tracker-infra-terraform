variable "server_name" {
  description = "The name of the sql server"
  type        = string
}

variable "databases" {
  description = "Databases"
  type = map(any)
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The name of the storage location"
  type        = string
}

variable "key_vault_id" {
  type = string
}

variable "ip_whitelist" {
  type = map(string)
}