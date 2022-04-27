// SecureCN Cluster

resource "securecn_k8s_cluster" "cluster" {
  kubernetes_cluster_context = var.kubernetes_cluster_context_name
  name = "${var.environment_name}_Cluster"
  orchestration_type = "KUBERNETES"
  ci_image_validation = false
  cd_pod_template = false
  connections_control = true
  multi_cluster_communication_support = false
  inspect_incoming_cluster_connections = false
  fail_close = false
  persistent_storage = false
}

// SecureCN Environments
resource "securecn_environment" "jenkins" {

  name = "${var.environment_name}_Jenkins"
  description = "Jenkins Environment"

  kubernetes_environment {
    cluster_name = securecn_k8s_cluster.cluster.name

    namespaces_by_labels = {
      app = "jenkins"
    }
  }
}
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

// SecureCN Connection Rules
resource "securecn_connection_rule" "External_to_Yelb_UI" {

  rule_name = "External to Yelb Web UI "
  source_by_external = true

  destination_by_pod_label {
    labels = {
      app = "yelb-ui"
    }
  }
}