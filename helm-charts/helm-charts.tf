resource "helm_release" "external-secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = "v0.8.3"
  namespace        = "external-secrets"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }
  set {
    name  = "webhook.port"
    value = 9443
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.secrets_manager_role.iam_role_arn
  }
  set {
    name  = "webhook.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.secrets_manager_role.iam_role_arn
  }
  set {
    name  = "certController.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.secrets_manager_role.iam_role_arn
  }
}

# resource "helm_release" "aws-efs-csi-driver" {
#   name       = "aws-efs-csi-driver"
#   repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
#   chart      = "aws-efs-csi-driver"
#   version    = "2.4.4"
#   namespace  = "kube-system"

#   set {
#     name  = "installCRDs"
#     value = true
#   }
#   set {
#     name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = module.efs_csi_controller_irsa_role.iam_role_arn
#     type = "string"
#   }
#   set {
#     name  = "node.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = module.efs_csi_controller_irsa_role.iam_role_arn
#     type = "string"
#   }
# }

resource "kubectl_manifest" "ingressclassparams" {
  yaml_body = file("${path.module}/1.yaml")
}

resource "kubectl_manifest" "targetgroupbindings" {
  yaml_body = file("${path.module}/2.yaml")
}


resource "helm_release" "loadbalancer_controller" {
  depends_on = [kubectl_manifest.targetgroupbindings, kubectl_manifest.ingressclassparams]
  name       = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.5.3"
  namespace  = "kube-system"

  set {
    name  = "image.repository"
    value = "public.ecr.aws/eks/aws-load-balancer-controller"
    type  = "string"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "image.tag"
    value = "v2.5.2"
    type  = "string"
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
    type  = "string"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.load_balancer_controller_irsa_role.iam_role_arn
    type  = "string"
  }

  set {
    name  = "vpcId"
    value = data.aws_eks_cluster.example.vpc_config[0].vpc_id
    type  = "string"
  }

  set {
    name  = "region"
    value = var.region
    type  = "string"
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
    type  = "string"
  }
  set {
    name  = "enableServiceMutatorWebhook"
    value = false
  }

}