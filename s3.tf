variable "my_bucket_name" {}

resource "aws_s3_bucket" "bucketcheck" {
  bucket        = "vantiprueba"
  acl           = "private"
  force_destroy = true
  versioning {
    enabled = true
  }
  tags = {
    Name = "My bucket"
  }
  # checkov:skip=CKV_AWS_144:Se desabilita la replicación entre regiones para mayor seguridad y ahorro de recursos.
  # checkov:skip=CKV_AWS_18:Se desabilita el registro de solicitudes mediante el registro de acceso al servidor por motivo de replicación de bucket.
  # checkov:skip=CKV_AWS_145:Se desabilita por cobro en kms.
  # checkov:skip=CKV_AWS_19:Se desabilita por cobro en kms.
}

resource "aws_s3_bucket_public_access_block" "access_good_1" {
  bucket = aws_s3_bucket.bucketcheck.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
