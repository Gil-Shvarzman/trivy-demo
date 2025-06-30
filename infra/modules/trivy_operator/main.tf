locals {
  chart_repo = "https://aquasecurity.github.io/helm-charts"
  values_file = "${path.module}/values.yaml"
}

module "app" {
  source             = "../argocd_app_k8s"
  argocd_namespace   = var.argocd_namespace
  argocd_release_id  = var.argocd_release_id        # propagate depends_on

  apps = {
    "trivy-operator" = {
      repo_url   = local.chart_repo
      chart       = "trivy-operator"          # using remote Helm repo
      target_rev = "0.29.1"
      dest_ns    = "trivy-system"
    }
  }
}