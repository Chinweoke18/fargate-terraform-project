
resource "aws_codebuild_project" "ecs_codebuild_project" {
  depends_on    = [aws_ecs_service.main, aws_ecr_repository.ecs]
  name          = "${var.microservice_name}-${var.microservice_environment}-codebuild"
  description   = "Build project for ${var.microservice_name} for ${var.app_name} on ${var.microservice_environment}"
  service_role  = aws_iam_role.ecs_codebuild.arn
  badge_enabled = false

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${var.microservice_name}-${var.app_environment}-log"
      stream_name = "${var.app_name}-${var.app_environment}-codebuild-stream"
    }

    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.code_repo
    git_clone_depth = 1
    buildspec       = data.template_file.buildspec.rendered

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = (var.app_environment == "prod" ? "main" : var.app_environment == "stg" ? "snapshot" : "staging-dev")

  tags = {
    createdby   = var.createdby
    project     = var.app_name
    environment = var.app_environment
    description = "This task is updated using terraform"
  }
}

data "template_file" "buildspec" {
  template = (var.tech == "java" ? file("${var.buildspec_java}") : file("${var.buildspec_node}")) 
  vars = {
    ecr_repo_url = aws_ecr_repository.ecs.repository_url
    loggroup     = aws_cloudwatch_log_group.codebuild_log_group.name
    region       = var.aws_region
    microservice_name    = var.microservice_name
    image_name   =  "${var.microservice_environment}-${var.app_name}/${var.microservice_name}"
  }
}