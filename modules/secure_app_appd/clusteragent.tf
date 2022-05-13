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

// Deploy Metrics Server to kube-system namespace
resource "null_resource" "metrics-server" {
  provisioner "local-exec" {
      working_dir = path.module
      command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
  }
}
// Create appdynamics namespace
resource "kubernetes_namespace" "appdynamics" {
  metadata {
    name = "appdynamics"
  }
}
// Deploy cluster-agent-operator
resource "null_resource" "cluster-agent-operator" {
  depends_on = [kubernetes_namespace.appdynamics]
  provisioner "local-exec" {
      working_dir = path.module
      command = "kubectl create -f cluster-agent-operator.yaml"
  }
}

// Create Secret using Account Key
resource "kubernetes_secret" "cluster-agent-secret" {
  depends_on = [kubernetes_namespace.appdynamics]
  metadata {
    name = "cluster-agent-secret"
    namespace = "appdynamics"
  }
  data = {
    controller-key = var.controller_accessKey
  }
}

// Deploy Cluster Agent Config
resource "kubectl_manifest" "cluster-agent" {
    yaml_body = <<YAML
apiVersion: cluster.appdynamics.com/v1alpha1
kind: Clusteragent
metadata:
  name: k8s-cluster-agent
  namespace: appdynamics
spec:
  appName: "${var.cluster_name}"
  controllerUrl: "${var.controller_url}"
  account: "${var.controller_account}"
  # docker image info
  image: "docker.io/appdynamics/cluster-agent:21.12.0"
  serviceAccountName: appdynamics-cluster-agent
  #
  # auto-instrumentation config
  #
  instrumentationMethod: Env
  nsToInstrumentRegex: ${var.namespaces}
  appNameStrategy: namespace
  instrumentationRules:
    - namespaceRegex: ${var.namespaces}
      language: java
      labelMatch:
        - framework: java
      imageInfo:
        image: "docker.io/appdynamics/java-agent:21.3.0"
        agentMountPath: /opt/appdynamics
        imagePullPolicy: "IfNotPresent"
YAML
}

