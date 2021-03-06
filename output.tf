// Outputs //

output "prod_ftd_mgmt_ip" {
  value = module.Infrastructure.ftd_mgmt_ip
}
output "prod_eks_public_ip" {
  value = module.Infrastructure.eks_public_ip
}
output "prod_eks_cluster_name" {
  value = module.Infrastructure.eks_cluster_name
}
output "prod_eks_cluster_api_endpoint" {
  value = module.Infrastructure.eks_cluster_api_endpoint
}