

resource "kubernetes_namespace" "appdynamics" {
  metadata {
    name = "appdynamics"
  }
}

resource "kubernetes_namespace" "metrics" {
  metadata {
    name = "metrics"
  }
}
# Per cluster agent requirements, we'll first need metrics-server installed.
# Comment this resource and the metrics namespace above if metrics-server
# is already installed in your environment. Also, note the extraArgs
# set in metrics-server-values.yaml and remove or readjust these values
# as needed for your environment.
resource "helm_release" "metrics-server" {
  name = "metrics-server"
  namespace = "metrics"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "metrics-server"

  values = [
    file("${path.module}/metrics-server-values.yaml")
  ]

}
# Deploy the AppDynamics cluster agent using AppDynamic's helm chart
resource "helm_release" "cluster-agent" {
  name = "cluster-agent"
  namespace = "appdynamics"
  repository = "https://appdynamics.github.io/appdynamics-charts"
  chart = "cluster-agent"

  values = [
    file("${path.module}/values.yaml")
  ]
# Values below are required the cluster agent configuration file. The values are
# available in sensitive.yaml.
  set_sensitive {
    name  = "controllerInfo.url"
    value = var.controller_url
  }

  set_sensitive {
    name  = "controllerInfo.account"
    value = var.controller_account
  }

  set_sensitive {
    name  = "controllerInfo.username"
    value = var.controller_username
  }

  set_sensitive {
    name  = "controllerInfo.password"
    value = var.controller_password
  }

  set_sensitive {
    name  = "controllerInfo.accessKey"
    value = var.controller_accessKey
  }
}
