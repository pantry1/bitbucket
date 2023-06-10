locals {
  arn_suffix        = replace("${data.aws_eks_cluster.example.identity[0].oidc[0].issuer}", "https://", "")
  oidc_provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.arn_suffix}"
}
