variable "profile" {
  type    = string
  default = "svc-terraform"
}

variable "cluster_name" {
  type    = string
  default = "testing-eks-2"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "secret_arn" {
  type    = list(string)
  default = ["arn:aws:secretsmanager:ap-south-1:998516096174:secret:SecretsStore-xanBIt"]
}

