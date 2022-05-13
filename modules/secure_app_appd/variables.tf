##################################################################################
# VARIABLES
##################################################################################

variable "controller_url" {
  description = "AppDynamics controller URL"
  type        = string
  sensitive   = true
}

variable "controller_account" {
  description = "DevNet AppDynamics controller account name"
  type        = string
  sensitive   = true
}

variable "controller_username" {
  description = "DevNet AppDynamics controller username"
  type        = string
  sensitive   = true
}

variable "controller_password" {
  description = "DevNet AppDynamics controller password"
  type        = string
  sensitive   = true
}

variable "controller_accessKey" {
  description = "DevNet AppDynamics controller access key"
  type        = string
  sensitive   = true
}
variable "cluster_name" {
  description = "EKS Cluster Name"
}
variable "namespaces" {
  description = "Namespaces to install java agent (ex: sock-shop, or for multiple ns, sock-shop|yelb|book)"
}