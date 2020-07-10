resource "aws_iam_role" "apigw_logs" {
  name = "APIGWCloudWatchGlobal"

  assume_role_policy = data.aws_iam_policy_document.apigw_assume.json
}

data "aws_iam_policy_document" "apigw_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "apigw_logs" {
  name = "APIGWLogs"
  role = aws_iam_role.apigw_logs.id

  policy = data.aws_iam_policy_document.apigw_logs.json
}

data "aws_iam_policy_document" "apigw_logs" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]
    resources = ["*"]
  }
}
