module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"


  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    root_volume_type = "gp2"

    attach_cluster_primary_security_group = false

    # Disabling and using externally provided security groups
    create_security_group = false
    iam_role_additional_policies = {
      ebs_csi_driver_policy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    }
  }

  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      ami_type       = "AL2_x86_64"
      instance_types = ["${var.instance_type}"]

      min_size     = 3
      max_size     = 12
      desired_size = var.nodes_count
    }
  }

  enable_irsa = true
  cluster_addons = {
    aws-ebs-csi-driver = {
      resolve_conflicts_on_create = "OVERWRITE"
      service_account_role_arn    = module.ebs_csi_irsa_role.iam_role_arn
    }
  }

}

module "ebs_csi_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.20.0"

  role_name             = "ebs-csi-${var.cluster_name}-role"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

}
