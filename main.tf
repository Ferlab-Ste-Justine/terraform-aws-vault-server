module "security_groups" {
  source = "../terraform-aws-vault-security-groups"

  member_group_name        = var.member_group_name
  load_balancer_group_name = var.load_balancer_group_name
  bastion_group_id         = var.bastion_group_id
}

module "vault_configs" {
  source               = "git::https://github.com/Ferlab-Ste-Justine/terraform-cloudinit-templates.git//vault?ref=v0.27.4"
  install_dependencies = var.install_dependencies
  hostname             = var.hostname
  release_version      = var.release_version
  tls                  = var.tls
  etcd_backend         = var.etcd_backend
}

resource "aws_instance" "vault" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.ssh_key_name
  subnet_id     = element(var.subnets, count.index)
  security_groups = [
    module.security_groups.member_group_id
  ]
  user_data = module.vault_configs.configuration

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.name}-${count.index}"
  }
}