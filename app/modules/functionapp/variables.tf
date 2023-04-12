variable "name" {
  description = "The name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The name of the storage location"
  type        = string
}

variable "storage_name" {
  type = string
}

variable "storage_access_key" {
  type = string
}

variable "keyvault_id" {
  type    = string
  default = null
}

variable "app_settings" {
  type    = map(string)
  default = {}
}