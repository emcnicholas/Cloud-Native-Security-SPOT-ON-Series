// Main //

// Deploy the Infrastructure
module "Infrastructure" {
  source = "./modules/infra"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region         = var.region
  ftd_user       = var.ftd_user
  ftd_pass       = var.ftd_pass
  env_name       = var.env_name
  env_id         = var.env_id
  aws_az1        = var.aws_az1
  aws_az2        = var.aws_az2
  key_name       = var.key_name
}

// Deploy Secure Cloud Analytics
module "Secure_Cloud_Analytics" {
  depends_on      = [module.Infrastructure]
  source          = "./modules/secure_cloud_analytics"
  sca_service_key = var.sca_service_key
}

// Deploy Secure Workload
#module "Secure_Workload" {
#  depends_on = [module.Infrastructure]
#  source = "./modules/secure_workload"
#  secure_workload_api_key    = var.secure_workload_api_key
#  secure_workload_api_sec    = var.secure_workload_api_sec
#  secure_workload_api_url    = var.secure_workload_api_url
#  secure_workload_root_scope = var.secure_workload_root_scope
#  eks_cluster_name           = module.Infrastructure.eks_cluster_name
#  env_id                     = var.env_id
#}

// Update AWS EKS Kubeconfig
resource "null_resource" "update_kubeconfig" {
  depends_on = [module.Infrastructure]
  provisioner "local-exec" {
      working_dir = path.module
      command = "aws eks --region ${var.region} update-kubeconfig --name ${module.Infrastructure.eks_cluster_name}"
  }
}


// Deploy Secure Application Cloud (CN)
module "Secure_CN" {
  depends_on                      = [null_resource.update_kubeconfig]
  source                          = "./modules/secure_cn"
  environment_name                = module.Infrastructure.eks_cluster_name
  kubernetes_cluster_context_name = module.Infrastructure.eks_cluster_arn
}

// Deploy Secure Application (AppD) -  I know so confusing :(
module "appdynamics_clusteragent" {
  source  = "3191110276/appdynamics/kubernetes//modules/clusteragent"
  version = "0.2.12"
  appd_account_name = var.appd_account_name
  appd_controller_key = var.appd_controller_key
  appd_global_account = var.appd_global_account
  appd_password = var.appd_password
  appd_username = var.appd_username
  cluster_name = module.Infrastructure.eks_cluster_name
}
// Providers //

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.4.1"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.11.3"
    }
    tetration = {
      source = "CiscoDevNet/tetration"
      version = "0.1.0"
    }
    securecn = {
      source = "Portshift/securecn"
      version = ">= 1.1.9"
    }
  }
}
provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region     =  var.region
}

provider "kubernetes" {
  host                   = module.Infrastructure.eks_cluster_api_endpoint
  cluster_ca_certificate = base64decode(module.Infrastructure.eks_cluster_ca)
  token                  = module.Infrastructure.eks_cluster_auth_token
  //load_config_file       = false
}

provider "kubectl" {
  host                   = module.Infrastructure.eks_cluster_api_endpoint
  cluster_ca_certificate = base64decode(module.Infrastructure.eks_cluster_ca)
  token                  = module.Infrastructure.eks_cluster_auth_token
  load_config_file       = false
}

provider "tetration" {
  api_key = var.secure_workload_api_key
  api_secret = var.secure_workload_api_sec
  api_url = var.secure_workload_api_url
  disable_tls_verification = true
}

provider "securecn" {
  access_key = var.secure_cn_access_key
  secret_key = var.secure_cn_secret_key
  //server_url = var.secure_cn_server_url
}