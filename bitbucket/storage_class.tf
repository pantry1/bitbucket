resource "kubernetes_storage_class" "fast_storage_class" {
  metadata {
    name = "fast"
  }
  storage_provisioner = "ebs.csi.aws.com"
  reclaim_policy      = "Retain"
  parameters = {
    type = "gp3"
    allowAutoIOPSPerGBIncrease : "true"
    encrypted : "true"
  }
  allow_volume_expansion = "true"
  volume_binding_mode    = "WaitForFirstConsumer"
}
