output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.cluster_name
}

output "oidc_provider_arn" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.oidc_provider_arn
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "rds_engine" {
  value = aws_db_instance.default.engine
}

output "db_subnet_group_name_vpc" {
  value = aws_db_subnet_group.default.vpc_id
}

output "ami_id" {
  value = data.aws_ami.debian11.image_id
}

output "eks_worker_nodes" {
  value = data.aws_instances.my_worker_nodes.private_ips
}

output "nfs-server-public-ip" {
  value = aws_instance.nfs-server.public_ip
}

output "nfs-server-private-ip" {
  value = aws_instance.nfs-server.private_ip
}

