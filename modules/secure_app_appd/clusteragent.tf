resource "kubernetes_namespace" "appdynamics" {
  metadata {
    name = "appdynamics"
  }
}

data "template_file" "values_yaml" {
  template = file("${path.module}/values.yaml")
  vars = {
    appd_url = var.controller_url
    appd_acct = var.controller_account
    appd_user = var.controller_url
    appd_pass = var.controller_password
    appd_key = var.controller_accessKey
  }
}

resource "helm_release" "cluster-agent" {
  name = "cluster-agent"
  namespace = "appdynamics"
  repository = "https://ciscodevnet.github.io/appdynamics-charts"
  chart = "cluster-agent"
  values = [
    file("${path.module}/values.yaml")
  ]
}

