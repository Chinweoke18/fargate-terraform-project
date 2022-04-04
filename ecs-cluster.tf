resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-${var.app_environment}-cluster"
}