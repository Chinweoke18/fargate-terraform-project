resource "aws_cloudwatch_log_group" "cb_log_group" {
  name              =  "${var.app_name}-${var.app_environment}-log"  
  retention_in_days = 30

  tags = {
    Name = "${var.app_name}-${var.app_environment}-log"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "${var.app_name}-${var.app_environment}-stream"
  log_group_name = aws_cloudwatch_log_group.cb_log_group.name
}

