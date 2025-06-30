# How-to

> [!NOTE]
> This PoC will deploy ArgoCD and `trivy-operator` in a two-stage apply.

## Steps

1. `terraform apply -target=module.argocd`
2. `terraform apply` (for the rest of the resources - this is because of Argo CRDs).