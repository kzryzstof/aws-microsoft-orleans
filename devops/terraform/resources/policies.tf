//  --------------------------------------------------------------------------------------------------------------------
//  ECR policy
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "app_runner" {
  role       = aws_iam_role.service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

//  --------------------------------------------------------------------------------------------------------------------
//  Orleans cluster DynamoDB policy.
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "dynamo_db_orleans_cluster_policy_attachment" {
  role       = aws_iam_role.service_role.name
  policy_arn = aws_iam_policy.dynamo_db_orleans_cluster_policy.arn
}

resource "aws_iam_policy" "dynamo_db_orleans_cluster_policy" {
  name = local.resources_names.policies.cluster
  path        = "/"
  description = "Policy to access the Orleans Cluster Dynamo DB table"

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
        Resource = aws_dynamodb_table.orleans_cluster.arn
      },
    ]
  })
  
  tags = local.tags
}

//  --------------------------------------------------------------------------------------------------------------------
//  Orleans cluster DynamoDB policy.
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "dynamo_db_data_grain_policy_attachment" {
  role       = aws_iam_role.service_role.name
  policy_arn = aws_iam_policy.dynamodb_data_grain_table_policy.arn
}

resource "aws_iam_policy" "dynamodb_data_grain_table_policy" {
  name = local.resources_names.policies.data_grain
  path        = "/"
  description = "Policy to access the Data Grain Dynamo DB table"

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
        Resource = aws_dynamodb_table.data_grain.arn
      },
    ]
  })

  tags = local.tags
}