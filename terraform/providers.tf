terraform {
  required_providers {
    hyperv = {
      source  = "taliesins/hyperv"
      version = "~> 1.0.4"
    }
  }
}
provider "hyperv" {
  user     = "Administrator"
  password = "YourAdminPassword"
  host     = "127.0.0.1"
  port     = 5985
  https    = false
  insecure = true
  use_ntlm = true
}
