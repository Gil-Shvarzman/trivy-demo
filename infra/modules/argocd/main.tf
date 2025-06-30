resource "kubernetes_namespace" "this" {
    metadata { 
        name = var.namespace 
    }
}

resource "helm_release" "this" {
    name       = "argo-cd"
    namespace  = kubernetes_namespace.this.metadata[0].name

    repository = "https://argoproj.github.io/argo-helm"
    chart      = "argo-cd"
    version    = var.chart_version          # default 8.0.0 (Argo CD 3.0.x)
}

output "namespace" {
    value = kubernetes_namespace.this.metadata[0].name
}

output "release_id"  { 
    value = helm_release.this.id 
} 