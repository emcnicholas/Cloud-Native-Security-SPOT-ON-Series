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