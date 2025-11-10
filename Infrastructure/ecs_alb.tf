locals {
  name = "${var.project}-${var.env}"
  tags = { Project = var.project, Env = var.env }
}

# CloudWatch log groups
resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/${local.name}-frontend"
  retention_in_days = 14
  tags              = local.tags
}
resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/${local.name}-backend"
  retention_in_days = 14
  tags              = local.tags
}

# ECS cluster
resource "aws_ecs_cluster" "this" {
  name = local.name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = local.tags
}

# Security groups
resource "aws_security_group" "alb_sg" {
  name   = "${local.name}-alb-sg"
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from internet"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.tags
}

resource "aws_security_group" "svc_sg" {
  name   = "${local.name}-svc-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    description     = "ALB to frontend"
  }
  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    description     = "ALB to backend"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

# ALB + listeners + target groups
resource "aws_lb" "alb" {
  name               = "${local.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets
  tags = local.tags
}

resource "aws_lb_target_group" "frontend_tg" {
  name        = "${local.name}-fe-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  health_check {
    path                = "/"
    matcher             = "200-399"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = local.tags
}

resource "aws_lb_target_group" "backend_tg" {
  name        = "${local.name}-be-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  health_check {
    path                = "/jobs"
    matcher             = "200-399"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = local.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# path-based rule to send /api/* to backend
resource "aws_lb_listener_rule" "api_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
  condition {
    path_pattern {
      values = ["/api/*", "/jobs/*"]
    }
  }
}

# ECS Task Definitions and Services (Fargate)

# frontend task definition
resource "aws_ecs_task_definition" "frontend" {
  family                   = "${local.name}-frontend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = "${aws_ecr_repository.frontend.repository_url}:latest"
      essential = true
      portMappings = [
        { containerPort = 3000, protocol = "tcp" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.frontend.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "frontend"
        }
      }

      environment = [
        { name = "BACKEND_BASE_URL", value = "/" },
        { name = "ALLOWED_HOSTS",     value = "all" },
        { name = "HOST",              value = "0.0.0.0" }
      ]

      # runtime override: re-export safe env values and then start the app
      # replace "npm start" if your image uses a different command (e.g. yarn start)
      command = [
  "sh",
  "-c",
  "npm ci --silent && npm run build && npx serve -s build -l 3000"
]
    }
  ])
  tags = local.tags
}




# backend task definition
resource "aws_ecs_task_definition" "backend" {
  family                   = "${local.name}-backend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "${aws_ecr_repository.backend.repository_url}:latest"
      essential = true
      portMappings = [
        { containerPort = 5000, protocol = "tcp" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.backend.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "backend"
        }
      }
      secrets = [
        # DATABASE_URL secret will be created in rds_secrets.tf and referenced here by arn
        { name = "DATABASE_URL", valueFrom = aws_secretsmanager_secret.dburl.arn }
      ]
    }
  ])
  tags = local.tags
}

# ECS services
resource "aws_ecs_service" "frontend" {
  name            = "${local.name}-frontend-svc"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.svc_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "frontend"
    container_port   = 3000
  }

  health_check_grace_period_seconds = 180

  depends_on = [aws_lb_listener.http]
  tags = local.tags
}

resource "aws_ecs_service" "backend" {
  name            = "${local.name}-backend-svc"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.svc_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_tg.arn
    container_name   = "backend"
    container_port   = 5000
  }

  depends_on = [aws_lb_listener_rule.api_rule]
  tags = local.tags
}
