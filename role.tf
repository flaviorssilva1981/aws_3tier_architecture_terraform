# Create IAM Role
resource "aws_iam_role" "ec2_s3_role" {
  name               = "ec2_s3_full_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach S3 full access policy to the role
resource "aws_iam_policy_attachment" "s3_full_access" {
  name       = "s3-full-access-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  roles      = [aws_iam_role.ec2_s3_role.name]
}