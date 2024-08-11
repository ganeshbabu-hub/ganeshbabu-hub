terraform {
  backend "s3" {
    bucket         = "veereandra-state-file"  
    key            = "state/terraform.tfstate"  
    region         = "us-east-1"  
  }
}
