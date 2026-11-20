output "web_url" {
  description = "Web service load balancer"
  value       = "http://${aws_lb.web.dns_name}"
}

output "api_url" {
  description = "API service load balancer"
  value       = "http://${aws_lb.api.dns_name}"
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}
