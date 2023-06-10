resource "helm_release" "bitbucket-data-center" {
  depends_on       = [helm_release.ingress-controller, helm_release.eck-operators]
  name             = "bitbucket"
  chart            = "bitbucket"
  version          = "1.12.0"
  namespace        = "bitbucket"
  create_namespace = true

  set {
    name  = "replicaCount"
    value = var.bitbucket_pods_count
  }
  set {
    name  = "database.url"
    value = "jdbc:postgresql://${var.rds_endpoint}/bitbucket"
    type  = "string"
  }
  set {
    name  = "database.driver"
    value = "org.postgresql.Driver"
    type  = "string"
  }
  set {
    name  = "database.credentials.secretName"
    value = "mysql-auth"
    type  = "string"
  }
  set {
    name  = "volumes.localHome.persistentVolumeClaim.create"
    value = true
  }
  set {
    name  = "volumes.localHome.persistentVolume.storageClassName"
    value = "gp2"
    type  = "string"
  }
  set {
    name  = "volumes.localHome.persistentVolumeClaim.storageClassName"
    value = "gp2"
    type  = "string"
  }
  set {
    name  = "volumes.localHome.persistentVolumeClaim.resources.requests.storage"
    value = "1Gi"
    type  = "string"
  }
  set {
    name  = "volumes.sharedHome.persistentVolume.create"
    value = true
  }
  set {
    name  = "volumes.sharedHome.persistentVolume.nfs.server"
    value = var.nfs_server
  }
  set {
    name  = "volumes.sharedHome.persistentVolume.nfs.path"
    value = var.nfs_mount_path
    type  = "string"
  }
  set {
    name  = "volumes.sharedHome.persistentVolumeClaim.create"
    value = true
  }
  set {
    name  = "volumes.sharedHome.persistentVolumeClaim.storageClassName"
    value = ""
  }
  set {
    name  = "ingress.create"
    value = true
  }
  set {
    name  = "bitbucket.sysadminCredentials.secretName"
    value = "bitbucket-auth"
    type  = "string"
  }
  set {
    name  = "bitbucket.service.type"
    value = "ClusterIP"
  }
  set {
    name  = "volumes.sharedHome.nfsPermissionFixer.enabled"
    value = true
  }

  set {
    name  = "bitbucket.elasticSearch.baseUrl"
    value = "elasticsearch-es-http.elastic.svc:9200"
  }

  set {
    name  = "bitbucket.elasticSearch.credentials.secretName"
    value = "elk-auth-secret"
  }
  set {
    name = "bitbucket.clustering.enabled"
    value = true
  }
  set {
    name = "ingress.host"
    value = "bitbucket"
  }
}