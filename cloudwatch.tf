resource "aws_cloudwatch_log_group" "cb_log_group" {
  name              =  "/ecs/${var.app_name}-${var.app_environment}"  
  retention_in_days = 30

  tags = {
    Name = "${var.app_name}-${var.app_environment}-log"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "${var.app_name}-${var.app_environment}-stream"
  log_group_name = aws_cloudwatch_log_group.cb_log_group.name
}


#codebuild loggroup and log streams
resource "aws_cloudwatch_log_group" "codebuild_log_group" {
  name              =  "/codebuild/"  
  retention_in_days = 30

  tags = {
    Name = "${var.app_name}-${var.app_environment}-log"
  }
}

resource "aws_cloudwatch_log_stream" "codebuild_log_stream" {
  name           = "${var.app_name}-${var.app_environment}-codebuild-stream"
  log_group_name = aws_cloudwatch_log_group.cb_log_group.name
}
