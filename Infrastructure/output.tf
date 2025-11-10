output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "ecr_frontend_repo" {
  value = aws_ecr_repository.frontend.repository_url
}

output "ecr_backend_repo" {
  value = aws_ecr_repository.backend.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "secrets_manager_db_arn" {
  value = aws_secretsmanager_secret.dburl.arn
}
