resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = "cluster"
  region = "ams3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.29.6-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}

resource "digitalocean_project" "mathias_sandbox" {
  name        = "mathias_sandbox"
  description = "A project to represent development resources."
  purpose     = "Web Application"
  environment = "Development"
  resources   = [digitalocean_kubernetes_cluster.cluster.urn]
}