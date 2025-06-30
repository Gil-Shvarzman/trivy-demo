variable "apps" {
    description = "Map of Argo CD apps to create"
    type = map(object({
        repo_url   = string
        chart       = string
        target_rev = string
        dest_ns    = string
    }))
}

variable "argocd_namespace" { 
    type = string 
}

variable "argocd_release_id" { 
    type = string 
}