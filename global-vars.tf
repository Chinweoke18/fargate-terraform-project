 # variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}


variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "3"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "app_name" {
  default     = "billing-app"
}

variable "app_environment" {
  default     = "prod"
}

variable "codepipeline_role" {
  default = "scripts/codepipeline_role.json"
}

variable "codepipeline_role_policy" {
  default = "scripts/codepipeline_role_policy.json"
}

variable "codebuild_role" {
  default = "scripts/codebuild_role.json"
}

variable "codebuild_role_policy" {
  default = "scripts/codebuild_role_policy.json"
}