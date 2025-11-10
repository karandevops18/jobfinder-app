# ECS task execution role (for pulling images & logging)
data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.project}-${var.env}-ecs-task-exec"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
  tags = { Project = var.project, Env = var.env }
}

resource "aws_iam_role_policy_attachment" "ecs_exec_managed" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Minimal task role to allow reading Secrets Manager and writing CloudWatch logs and S3 (optional)
data "aws_iam_policy_document" "task_role_policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.project}-${var.env}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
  tags = { Project = var.project, Env = var.env }
}

resource "aws_iam_role_policy" "ecs_task_custom_policy" {
  name   = "${var.project}-${var.env}-task-policy"
  role   = aws_iam_role.ecs_task_role.id
  policy = data.aws_iam_policy_document.task_role_policy.json
}
