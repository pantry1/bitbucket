module "secrets_manager_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.20.0"

  role_name = "secrets-manager-${var.cluster_name}-role"

  attach_external_secrets_policy        = true
  external_secrets_secrets_manager_arns = var.secret_arn

  oidc_providers = {
    main = {
      provider_arn               = local.oidc_provider_arn
      namespace_service_accounts = ["external-secrets:external-secrets"]
    }
  }
}

module "load_balancer_controller_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.20.0"

  role_name                              = "load-balancer-controller-${var.cluster_name}-role"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = local.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

}

# module "efs_csi_controller_irsa_role" {
# source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
# version = "5.20.0"
# 
# role_name             = "efs-csi-${var.cluster_name}-role"
# attach_efs_csi_policy = true
# 
# oidc_providers = {
# ex = {
# provider_arn               = local.oidc_provider_arn
# namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
# }
# }
# }
