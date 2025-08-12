# resource "aws_key_pair" "bastion_key" {
#   key_name   = "bastion-key"
#   public_key = var.bastion_public_key
# }

# module "bastion" {
#   source = "./modules/ec2"

#   instance_name               = "bastion"
#   instance_type               = "t3.medium"
#   os_name                     = "ubuntu"
#   root_volume_size            = 30
#   root_volume_type            = "gp2"
#   key_name                    = aws_key_pair.bastion_key.key_name
#   subnet_id                   = module.vpc.public_subnet_ids[0]
#   vpc_security_group_ids      = [module.vpc.security_group_id]
#   associate_public_ip_address = true
#   enable_ssm                 = true
#   # Catatan: Bila hanya ingin akses via SSM Session Manager,
#   # Anda bisa menonaktifkan SSH key dengan menghapus/komentari "key_name".

#   depends_on = [module.vpc]
# }
