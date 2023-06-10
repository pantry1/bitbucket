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

variable "cluster_version" {
  type    = string
  default = "1.27"
}

variable "instance_type" {
  type    = string
  default = "t3.xlarge"
}

variable "nodes_count" {
  type    = string
  default = "3"
}

variable "db_username" {
  default = "foo"
}

variable "db_password" {
  default = "foobarbaz"
}

variable "db_instance_type" {
  default = "db.t3.micro"
}

variable "nfs_instance_type" {
  default = "t3.xlarge"
}

variable "nfs_server_size" {
  default = "50"
}

variable "vpc_id" {
  default = "vpc-019ef4a85d2f63f0d"
}

variable "private_subnet_ids" {
  default = ["subnet-0f24bd6079aa0a0d2", "subnet-0abb056b6ac5b2e39", "subnet-0d5351b7c6434ac94"]
}

variable "public_subnet_id" {
  default = "subnet-0ea9fc6a65214a1db"
}