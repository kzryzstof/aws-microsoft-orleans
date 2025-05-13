resource "aws_iam_role" "deployment_role" {
  name = local.resources_names.service_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          # Important: apprunner.amazonaws.com or tasks.apprunner.amazonaws.com prevents the image from being pulled.
          Service = "build.apprunner.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_role" "service_role" {
  name = local.resources_names.service_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}

