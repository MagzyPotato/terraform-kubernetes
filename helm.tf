resource "null_resource" "kube-config" {
  provisioner "local-exec" {
    command = "doctl kubernetes cluster kubeconfig save cluster"
  }
  depends_on = [digitalocean_kubernetes_cluster.cluster]
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  depends_on = [null_resource.kube-config]
}