provider "aws" {
  region = "us-east-2"  # Set your desired region
}

resource "aws_iam_role" "eks_role" {
  name = "eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet_1" {
  vpc_id            = "vpc-074c1292c66a0913b"  # Add quotes around the VPC ID
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id            = "vpc-074c1292c66a0913b"  # Add quotes around the VPC ID
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2b"
}

resource "aws_eks_cluster" "my_eks_cluster" {
  name     = "my-eks-cluster_1"
  role_arn = "arn:aws:iam::761018874575:role/my-eks-cluster"  # Add quotes around the ARN
  vpc_config {
    subnet_ids = [
      "subnet-068f67d53720f8679",  # Add quotes around the subnet IDs
      "subnet-07feb5f7bc4e0fa8c"   # Add quotes around the subnet IDs
    ]
  }
}

