module "argocd" {
  source = "./modules/argocd"
}

module "trivy_operator" {
  source            = "./modules/trivy_operator"
  argocd_namespace  = module.argocd.namespace
  argocd_release_id = module.argocd.release_id
  depends_on = [module.argocd]
}