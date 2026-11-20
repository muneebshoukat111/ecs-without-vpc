output "web_url" {
  value = "http://${module.web_alb.dns_name}"
}

output "api_url" {
  value = "http://${module.api_alb.dns_name}"
}

output "cluster_name" {
  value = module.cluster.cluster_name
}
