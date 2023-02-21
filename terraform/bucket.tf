terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"

  backend "s3" {
    bucket = "sukumar-tf-state"
    key    = "sukumar-tf.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  version = "~>3.0"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "sukumar-test-bucket"

  acl = "public-read"

  policy = <<EOF
{
   "Version" : "2012-10-17",
   "Statement" : [
      {
         "Action" : [
             "s3:GetObject"
          ],
         "Effect" : "Allow",
         "Resource" : "arn:aws:s3:::sukumar-test-bucket/*",
         "Principal" : "*"
      }
    ]
  }
EOF

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}