 # variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-2"
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