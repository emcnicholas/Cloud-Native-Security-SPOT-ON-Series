// Variables //

// Infrastructure Variables
variable "aws_access_key" {
  description = "AWS Access Key"
}
variable "aws_secret_key" {
  description = "AWS Secret Key"
}
variable "region" {
  description = "AWS Region ex: us-east-1"
}
variable "ftd_user" {
  description = "Secure Firewall Username"
  default = "admin"
}
variable "ftd_pass" {
  description = "Secure Firewall Password"
}
variable "env_name" {
  description = "Name associated with this environment"
}
variable "env_id" {
  description = "ID associated with this environment"
}
variable "aws_az1" {
  description = "AWS Availability Zone 1 ex: us-east-1a"
}
variable "aws_az2" {
  description = "AWS Availability Zone 2 ex: us-east-1b"
}
variable "key_name" {
  description = "SSH key created in AWS region this deployment is being deployed to"
}
variable "remote_hosts" {
  description = "Remote hosts allowed to access the environment"
  default = "0.0.0.0/0"
}

// Secure Cloud Analytics Variables
variable "sca_service_key" {
  description = "Secure Cloud Analytics Service Key"
}

// Secure Workload Variables
variable "secure_workload_api_key" {
  description = "Secure Workload API Key"
}
variable "secure_workload_api_sec" {
  description = "Secure Workload API Secret"
}
variable "secure_workload_api_url" {
  description = "Secure Workload URL ex: https://FQDN"
}
variable "secure_workload_root_scope" {
  description = "The ID of the Secure Workload Root Scope"
}

// Panoptica Variables
variable "secure_cn_access_key" {
  description = "Secure CN Access Key"
}
variable "secure_cn_secret_key" {
  description = "Secure CN Secret Key"
}

// AppDynamics Secure App Variables
variable "appd_url" {
  description = "URL of the Appd SaaS instance ex: https://mycompany.saas.appdynamics.com"
  type        = string
  sensitive   = true
}
variable "appd_account_name" {
  description = "Name of the AppD Account (can be found at Settings > License > Account Details > Name"
  type        = string
  sensitive   = true
}
variable "appd_username" {
  description = "DevNet AppDynamics controller username"
  type        = string
  sensitive   = true
}
variable "appd_password" {
  description = "DevNet AppDynamics controller password"
  type        = string
  sensitive   = true
}
variable "appd_accessKey" {
  description = "AppD Access Key (can be found at Settings > License > Account Details > Access Key"
  type        = string
  sensitive   = true
}
