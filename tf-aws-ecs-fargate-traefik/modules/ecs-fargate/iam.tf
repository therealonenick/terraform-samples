data "aws_iam_policy_document" "ecs_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Controller Task
data "aws_iam_policy_document" "traefik_demo_task_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:ListContainerInstances"
    ]
    resources = [aws_ecs_cluster.traefik_demo.arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecs:RunTask"
    ]
    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values = [
        aws_ecs_cluster.traefik_demo.arn,
      ]
    }
    resources = ["arn:aws:ecs:${local.region}:${local.account_id}:task-definition/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecs:StopTask",
      "ecs:DescribeTasks"
    ]
    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values = [
        aws_ecs_cluster.traefik_demo.arn,
      ]
    }
    resources = ["arn:aws:ecs:${local.region}:${local.account_id}:task/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = ["arn:aws:ssm:${local.region}:${local.account_id}:parameter/reports*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = ["arn:aws:kms:${local.region}:${local.account_id}:alias/aws/ssm"]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["arn:aws:iam::${local.account_id}:role/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.traefik_demo_log_group.arn}:*",
      "arn:aws:logs:${local.region}:${local.account_id}:log-group:/aws/ecs/*",
    "arn:aws:logs:${local.region}:${local.account_id}:log-group:ecs/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "elasticfilesystem:ClientMount",
      "ecr:GetAuthorizationToken",
      "ecs:RegisterTaskDefinition",
      "ecs:ListClusters",
      "ecs:DescribeContainerInstances",
      "ecs:ListTaskDefinitions",
      "ecs:ListTasks",
      "ecs:DescribeTaskDefinition",
      "ecs:DeregisterTaskDefinition"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "traefik_demo_task_policy" {
  name   = "${var.name_prefix}-controller-task-policy"
  policy = data.aws_iam_policy_document.traefik_demo_task_policy.json
}

resource "aws_iam_role" "traefik_demo_task_role" {
  name               = "${var.name_prefix}-controller-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "traefik_demo_task" {
  role       = aws_iam_role.traefik_demo_task_role.name
  policy_arn = aws_iam_policy.traefik_demo_task_policy.arn
}

//CloudWatch
data "aws_iam_policy_document" "cloudwatch" {
  policy_id = "key-policy-cloudwatch"
  statement {
    sid = "Enable IAM User Permissions"
    actions = [
      "kms:*",
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
    resources = ["*"]
  }
  statement {
    sid = "AllowCloudWatchLogs"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${local.region}.amazonaws.com"]
    }
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_execution_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.name_prefix}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_policy.json
  tags               = var.tags
}

resource "aws_iam_policy" "ecs_execution_policy" {
  name   = "${var.name_prefix}-ecs-execution-policy"
  policy = data.aws_iam_policy_document.ecs_execution_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.traefik_demo_task_policy.arn
}