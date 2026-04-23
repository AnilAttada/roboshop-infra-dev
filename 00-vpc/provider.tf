terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version ="6.36.0"
        }
    }

    backend "s3" {
        bucket = "a-remote-state-dev"
        key = "vpc-test"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}

provider "aws" {
    #configuration options
    region = "us-east-1"
}