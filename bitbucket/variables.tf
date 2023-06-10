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

variable "rds_endpoint" {
  default = "terraform-20230610052632767900000001.cmlkd6hzxk08.ap-south-1.rds.amazonaws.com:5432"
}

variable "rds_driver" {
  default = "org.postgresql.Driver"
}

variable "nfs_server" {
  default = "10.0.4.182"
}

variable "nfs_mount_path" {
  default = "/nfsshare"
}

variable "db_username" {
  default = "foo"
}

variable "db_password" {
  default = "foobarbaz"
}

variable "es_username" {
  default = "elastic"
}

variable "es_password" {
  default = "6b#J4T7m&DJp"
}

variable "bitbucket_pods_count" {
  default = 1
}
