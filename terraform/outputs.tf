output "ecr_repo_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.portfolio_ecr.repository_url
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.portfolio_eks.name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.portfolio_eks.endpoint
}
