resource "helm_release" "ingress-controller" {
  name             = "nginx-ingress"
  repository       = "https://helm.nginx.com/stable"
  chart            = "nginx-ingress"
  version          = "0.17.1"
  namespace        = "nginx"
  create_namespace = true  
}
  