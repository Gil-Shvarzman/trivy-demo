terraform {
  required_version = ">= 1.7.0"
  required_providers {
    kubernetes = { source = "hashicorp/kubernetes", version = ">= 2.30" }
    helm       = { source = "hashicorp/helm",       version = ">= 3.0.1" }
    argocd     = { source = "argoproj-labs/argocd", version = ">= 6.0" }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "argocd" {
  server_addr = "argocd-server.argocd.svc.cluster.local:443"
  insecure    = true        # self-signed cert in a PoC
  auth_token  = var.argocd_admin_token
}