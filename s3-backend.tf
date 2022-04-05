#create S3 backend
resource "aws_s3_bucket" "s3_backend" {
    bucket = "${var.app_name}-${var.app_environment}-tf-state"
   # acl    = "private"

    lifecycle {
        prevent_destroy = true
     }

    # versioning {
    #     enabled = true
    # }

    tags = {
        name = "tf-state-bucket"
     }

}


resource "aws_dynamodb_table" "tf-state-table" {
    name     = "${var.app_name}-${var.app_environment}-tf-state-lock-table"
    hash_key = "LockID"
    read_capacity = "8"
    write_capacity = "8"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        name = "tf-state-lock-table"
     }
    
    depends_on = [aws_s3_bucket.s3_backend]
}


 terraform {
     backend "s3" {
        
         bucket         = "billing-app-prod-tf-state"
         key            = "terraform.tfstate"
         region         = "us-east-1"
         dynamodb_table = "billing-app-prod-tf-state-lock-table"
         encrypt        = true
     }
 }


#Artifact store in S3 prod
resource "aws_s3_bucket" "codepipeline_bucket_prod" {
  bucket = "${var.app_name}-${var.app_environment}-artifact-store"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl_prod" {
  bucket = aws_s3_bucket.codepipeline_bucket_prod.id
  acl    = "private"
}

#Artifact store in S3 stging
resource "aws_s3_bucket" "codepipeline_bucket_stg" {
  bucket = "${var.app_name}-${var.app_environment}-artifact-store-stg"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl_stg" {
  bucket = aws_s3_bucket.codepipeline_bucket_stg.id
  acl    = "private"
}

#Artifact store in S3 dev
resource "aws_s3_bucket" "codepipeline_bucket_dev" {
  bucket = "${var.app_name}-${var.app_environment}-artifact-store-dev"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl_dev" {
  bucket = aws_s3_bucket.codepipeline_bucket_dev.id
  acl    = "private"
}