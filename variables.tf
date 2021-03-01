variable "subscription_id"{}
variable "tenant_id"{}
variable "client_id"{}
variable "client_secret"{}
variable "resource_groupname" {
  default = "<Enter resource group name>"
}
variable "location" {
  type = string
  default = "westeurope"
}
