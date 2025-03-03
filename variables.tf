variable "name" {
  description = "Nom du serveur Vault"
  type        = string
}

variable "ami_id" {
  description = "AMI utilisée pour l'instance"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.medium"
}

variable "ssh_key_name" {
  description = "Nom de la clé SSH"
  type        = string
}

variable "subnets" {
  description = "Liste des subnets où les instances seront créées"
  type        = list(string)
}

variable "member_group_name" {
  description = "Nom du Security Group pour Vault"
  type        = string
}

variable "load_balancer_group_name" {
  description = "Nom du Security Group pour le Load Balancer"
  type        = string
}

variable "bastion_group_id" {
  description = "ID du Security Group pour le Bastion"
  type        = string
}

variable "volume_size" {
  description = "Taille du volume de stockage en GiB"
  type        = number
  default     = 20
}

variable "instance_count" {
  description = "Nombre d'instances Vault à créer"
  type        = number
  default     = 1
}