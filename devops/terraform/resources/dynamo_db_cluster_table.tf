resource "aws_dynamodb_table" "orleans_cluster" {
  name           = "OrleansClusterTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "DeploymentId"
  range_key      = "Address"

  attribute {
    name = "DeploymentId"
    type = "S"
  }

  attribute {
    name = "Address"
    type = "S"
  }

  ttl {
    attribute_name = "TtlAttribute"
    enabled        = true
  }

  tags = local.tags
}


//  --------------------------------------------------------------------------------------------------------------------
//  App Runner permissions
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "dynamo_db_policy_attachment" {
  role       = aws_iam_role.app_runner_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_policy" "dynamodb_policy" {
  name = "AwsOrleansDynamodbPolicy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:UpdateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}