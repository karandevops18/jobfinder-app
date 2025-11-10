resource "aws_ecr_repository" "frontend" {
  name                 = var.frontend_ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = { Project = var.project, Env = var.env }
}

resource "aws_ecr_repository" "backend" {
  name                 = var.backend_ecr
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = { Project = var.project, Env = var.env }
}
