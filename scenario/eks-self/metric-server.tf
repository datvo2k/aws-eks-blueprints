resource "helm_release" "metrics_server" {
  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "6.6.5"

  set {
    name  = "metrics.enabled"
    value = false
  }
}
