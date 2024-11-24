variable "s3_use_path_style"{
    default = "false"
}

provider "aws"{
    s3_use_path_style = var.s3_use_path_style
}

resource "aws_s3_bucket" "sample" {
    bucket = "sample-bucket"
}

resource "aws_sns?topic"   "sample"{
    name = "sample-topic"
}