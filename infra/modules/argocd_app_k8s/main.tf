locals { 
    ns = var.argocd_namespace 
}

resource "kubernetes_manifest" "app" {
  for_each = var.apps

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = each.key
      namespace = local.ns
    }
    spec = {
      project = "default"
      source = {
        repoURL        = each.value.repo_url
        chart           = each.value.chart
        targetRevision = each.value.target_rev
        helm           = {}         # let Argo treat it as a Helm chart
      }
      destination = {
        name      = "in-cluster"
        namespace = each.value.dest_ns
      }
      syncPolicy = {
        automated = { 
          prune = true, selfHeal = true 
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }

  # Make sure the CRD is present first
  depends_on = [var.argocd_release_id]
}