data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "../../src"
    output_path = "cleanup_worker.zip"
}

resource "aws_lambda_function" "cleanup_worker_lambda" {
    filename = "cleanup_worker.zip"
    function_name = "${local.environment}-cleanup-worker"
    role = aws_iam_role.cleanup_worker_role.arn
    handler = "lambda.lambda_handler"
    timeout = 30
    runtime = "python3.8"
    #layers = [aws_lambda_layer_version.example.arn]
    layers = ["arn:aws:lambda:us-east-1:${local.account_number}:layer:${local.log4sdc_layer}"]
    environment {
      variables = {
        LOG_LEVEL = "${local.log_level}"
      }
    }
    tags = local.global_tags
}

resource "aws_iam_role" "cleanup_worker_role" {
    name = "${local.environment}-cleanup-worker-role"
    assume_role_policy = file("assume_role_policy.json")
    tags = local.global_tags
}

resource "aws_iam_role_policy" "cleanup_worker_policy" {
    name="${local.environment}-cleanup-worker-policy"
    role = aws_iam_role.cleanup_worker_role.id
    policy = file("cleanup_worker_policy.json")
}


resource "aws_cloudwatch_event_rule" "cleanup_worker_scheduler" {
    name = "${local.environment}-cleanup-worker-scheduler"
    description = "Periodically invokes cleanup-worker lambda function"
    schedule_expression = "cron(30 6 * * ? *)"
    tags = local.global_tags
}

resource "aws_cloudwatch_event_target" "cleanup_worker_event_target" {
    rule = aws_cloudwatch_event_rule.cleanup_worker_scheduler.name
    arn = aws_lambda_function.cleanup_worker_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_cleanup_worker" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.cleanup_worker_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.cleanup_worker_scheduler.arn
}

