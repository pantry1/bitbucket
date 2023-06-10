# data "template_file" "secret_store_yaml" {
#   template = file("${path.module}/files/secretstore.yaml")
#   vars = {
#     REGION             = var.region    
#   }
# }

resource "kubectl_manifest" "secret-store" {
  yaml_body = file("${path.module}/files/secretstore.yaml")
}
