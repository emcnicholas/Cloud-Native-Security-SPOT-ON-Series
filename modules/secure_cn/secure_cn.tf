// SecureCN Cluster
resource "securecn_k8s_cluster" "cluster" {
  kubernetes_cluster_context = var.kubernetes_cluster_context_name
  name = var.environment_name
  orchestration_type = "EKS"
  ci_image_validation = false
  cd_pod_template = false
  connections_control = true
  inspect_incoming_cluster_connections = true
  multi_cluster_communication_support = false
  fail_close = false
  persistent_storage = false
  trace_analyzer = true
  api_intelligence_dast = false
}

// SecureCN Environments
resource "securecn_environment" "yelb" {

  name = "${var.environment_name}_Yelb_App"
  description = "Yelb App Environment"

  kubernetes_environment {
    cluster_name = securecn_k8s_cluster.cluster.name

    namespaces_by_labels = {
      app = "yelb"
    }
  }
}

#// SecureCN Connection Rules
#
#// Yelb Connection Rules
#resource "securecn_connection_rule" "External_to_Yelb_UI" {
#  rule_name = "External to Yelb Web UI "
#  source_by_external = true
#  destination_by_pod_name {
#    names = ["yelb-ui"]
#  }
#}
#
#resource "securecn_connection_rule" "Yelb_UI_to_App" {
#  rule_name = "Yelb UI to App"
#  source_by_pod_name {
#    names = ["yelb-ui"]
#  }
#  destination_by_pod_name {
#    names = ["yelb-appserver"]
#  }
#}
#
#resource "securecn_connection_rule" "Yelb_App_to_DB" {
#  rule_name = "Yelb App to DB"
#  source_by_pod_name {
#    names = ["yelb-appserver"]
#  }
#  destination_by_pod_name {
#    names = ["yelb-db"]
#  }
#}
#
#resource "securecn_connection_rule" "Yelb_App_to_Redis" {
#  rule_name = "Yelb App to Redis"
#  source_by_pod_name {
#    names = ["yelb-appserver"]
#  }
#  destination_by_pod_name {
#    names = ["redis-server"]
#  }
#}