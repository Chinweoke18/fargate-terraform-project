# ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid = ""
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


#AWS-Github integration
data "aws_codestarconnections_connection" "ecs_codepipeline" {
   arn = "arn:aws:codestar-connections:us-east-1:441260638094:connection/4236aeca-2e88-4edf-9e20-822606a64a12"
 }


#codepipeline role and policy
resource "aws_iam_role" "ecs_codepipeline" {
  name = "${var.app_name}-${var.app_environment}-codepipeline-role"

  assume_role_policy = data.template_file.codepipeline_role.rendered
}

data "template_file" "codepipeline_role" {
  template = file("${var.codepipeline_role}")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.app_name}-${var.app_environment}-codepipeline_policy"
  role = aws_iam_role.ecs_codepipeline.name

  policy = data.template_file.codepipeline_role_policy.rendered
}

data "template_file" "codepipeline_role_policy" {
  template = file("${var.codepipeline_role_policy}")
}


#codebuild role and policy
resource "aws_iam_role" "ecs_codebuild" {
  name = "${var.app_name}-${var.app_environment}-codebuild-role"

  assume_role_policy = data.template_file.codebuild_role.rendered

}

data "template_file" "codebuild_role" {
  template = file("${var.codebuild_role}")
}


resource "aws_iam_role_policy" "ecs-role-policy" {
  name = "${var.app_name}-${var.app_environment}-codebuild-policy"
  role = aws_iam_role.ecs_codebuild.name

  policy = data.template_file.codebuild_role_policy.rendered
}

data "template_file" "codebuild_role_policy" {
  template = file("${var.codebuild_role_policy}")
}

