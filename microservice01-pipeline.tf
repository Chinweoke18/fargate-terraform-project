resource "aws_codepipeline" "ecs_codepipeline_project" {
  depends_on = [aws_codebuild_project.ecs_codebuild_project]
  name       = "${var.microservice_name}-${var.microservice_environment}-pipeline"
  role_arn   = aws_iam_role.ecs_codepipeline.arn

  artifact_store {
    location = (var.app_environment == "prod" ? "${var.app_name}-${var.app_environment}-artifact-store" : var.app_environment == "stg" ? "${var.app_name}-${var.app_environment}-artifact-store-stg" : "${var.app_name}-${var.app_environment}-artifact-store-stg")
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = data.aws_codestarconnections_connection.ecs_codepipeline.arn
        FullRepositoryId = var.repo_id
        BranchName       = (var.microservice_environment == "prod" ? "main" : var.microservice_environment == "stg" ? "snapshot" : "staging-dev")
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.ecs_codebuild_project.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName       = "${var.app_name}-${var.app_environment}-cluster"
        ServiceName       = aws_ecs_service.main.name
        FileName          = "imagedefinitions.json"
        DeploymentTimeout = "30"
      }
    }
  }
}

# resource "aws_codestarconnections_connection" "github_connection" {
#   name          = "example-connection"
#   provider_type = "GitHub"
# }



