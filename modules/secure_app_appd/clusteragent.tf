#resource "kubernetes_namespace" "appdynamics" {
#  metadata {
#    name = "appdynamics"
#  }
#}
#
#data "template_file" "values_yaml" {
#  template = file("${path.module}/values.yaml")
#  vars = {
#    appd_url = var.controller_url
#    appd_acct = var.controller_account
#    appd_user = var.controller_url
#    appd_pass = var.controller_password
#    appd_key = var.controller_accessKey
#  }
#}
#
#resource "helm_release" "cluster-agent" {
#  name = "cluster-agent"
#  namespace = "appdynamics"
#  repository = "https://ciscodevnet.github.io/appdynamics-charts"
#  chart = "cluster-agent"
#  values = [
#    file("${path.module}/values.yaml")
#  ]
#}
#
#
#resource "null_resource" "metrics-server" {
#  provisioner "local-exec" {
#      working_dir = path.module
#      command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
#  }
#}
#resource "kubernetes_namespace" "appdynamics" {
#  metadata {
#    name = "appdynamics"
#  }
#}
#resource "null_resource" "cluster-agent-operator" {
#  provisioner "local-exec" {
#      working_dir = path.module
#      command = "kubectl create -f cluster-agent-operator.yaml"
#  }
#}


