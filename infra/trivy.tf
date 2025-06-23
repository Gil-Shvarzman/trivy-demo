resource "kubernetes_namespace" "trivy" {
  metadata { name = "trivy-system" }
}

resource "argocd_application" "trivy_operator" {
  metadata {
    name      = "trivy-operator"
    namespace = "argocd"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/Gil-Shvarzman/trivy-demo.git"
      path            = "trivy-operator"   # directory inside gitops/
      target_revision = "main"
      plugin          = "helm"
      helm {
        value_files = ["values.yaml"]
      }
    }

    destination {
      name      = "in-cluster"
      namespace = kubernetes_namespace.trivy.metadata[0].name
    }

    sync_policy {
      automated {
        prune    = true
        self_heal = true
      }
    }
  }
}