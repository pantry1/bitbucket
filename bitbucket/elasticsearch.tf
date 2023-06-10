resource "helm_release" "eck-operators" {
  name             = "eck-operator"
  repository       = "https://helm.elastic.co"
  chart            = "eck-operator"
  version          = "2.8.0"
  namespace        = "elastic"
  create_namespace = true
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [helm_release.eck-operators]

  create_duration = "30s"
}

resource "helm_release" "eck-elasticsearch" {
  depends_on = [time_sleep.wait_30_seconds]
  name       = "eck-elasticsearch"
  #repository       = "https://helm.elastic.co"
  chart      = "eck-elasticsearch"
  namespace  = "elastic"


  set {
    name  = "auth.fileRealm[0].secretName"
    value = "elk-auth-secret"
  }
  set {
    name  = "http.service.spec.type"
    value = "ClusterIP"
  }
  set {
    name  = "nodeSets[0].podTemplate.spec.containers[0].resources.limits.memory"
    value = "2Gi"
  }
  set {
    name  = "nodeSets[0].podTemplate.spec.containers[0].resources.requests.memory"
    value = "2Gi"
  }
  set {
    name  = "storage"
    value = "1Gi"
  }
  set {
    name  = "storageClassName"
    value = "gp2"
  }

}