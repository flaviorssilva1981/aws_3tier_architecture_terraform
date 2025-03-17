resource "aws_key_pair" "sandbox" {
  key_name   = "sandbox"               # The name of your key pair
  public_key = file("/mnt/c/guga/projetos/aws/infra/aws_3tier_architecture_terraform/sandbox.pub")   # Path to your public key file
}
