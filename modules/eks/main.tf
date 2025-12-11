locals {
  base_tags = var.tags

  cluster_role_policies = toset([
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
  ])

  node_role_policies = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ])
}

resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = local.base_tags
}

resource "aws_iam_role_policy_attachment" "cluster" {
  for_each   = local.cluster_role_policies
  policy_arn = each.value
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role" "node_group" {
  name = "${var.cluster_name}-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = local.base_tags
}

resource "aws_iam_role_policy_attachment" "node_group" {
  for_each   = local.node_role_policies
  policy_arn = each.value
  role       = aws_iam_role.node_group.name
}

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  dynamic "encryption_config" {
    for_each = var.kms_key_arn != "" ? [1] : []
    content {
      provider {
        key_arn = var.kms_key_arn
      }
      resources = ["secrets"]
    }
  }

  tags = merge(local.base_tags, { Name = var.cluster_name })

  depends_on = [aws_iam_role_policy_attachment.cluster]
}

resource "aws_eks_addon" "this" {
  for_each                    = var.addons
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = each.key
  addon_version               = try(each.value.version, null)
  resolve_conflicts_on_update = try(each.value.resolve_conflicts_on_update, "PRESERVE")

  tags = local.base_tags
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable_percentage = 33
  }

  instance_types = [var.instance_type]
  disk_size      = var.node_disk_size

  labels = var.node_labels

  tags = merge(local.base_tags, { Name = "${var.cluster_name}-node-group" })

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [scaling_config[0].desired_size]
  }

  depends_on = [aws_iam_role_policy_attachment.node_group]
}
