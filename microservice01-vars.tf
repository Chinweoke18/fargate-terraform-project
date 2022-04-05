variable "microservice_name" {
  description = "name of the microservice to be deployed"
  default     = "microservice01"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "nginx:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "microservice_environment" {
  default     = "prod"
}

variable "repo_id" {
  default = "chinweoke18/hellp-app"
}

variable "buildspec_java" {
  default = "scripts/buildspec-java.yaml"
}

variable "buildspec_node" {
  default = "scripts/buildspec-node.yaml"
}

variable "code_repo" {
  default = "https://github.com/Chinweoke18/hellp-app.git"
}

variable "repo_branch" {
  default = "main"
}

variable "tech" {
  default = "node"
}

variable "createdby" {
  default = "chinweoke"
}

# variable "ecr_repo_url" {
#   default = "aws_ecr_repository.ecs.repository_url"
# }