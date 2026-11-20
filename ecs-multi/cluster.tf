# One cluster shared by both services
resource "aws_ecs_cluster" "this" {
  name = "${var.name}-cluster"
}
