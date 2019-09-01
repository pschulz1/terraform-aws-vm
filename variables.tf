variable "environment_name" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "ttl" {
  type    = number
  default = 48
}

variable "name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "subnet_id" {
  type = string
}

variable "ami_id" {
  type    = string
  default = null
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = null
}

variable "ssh_public_key" {
  description = "If you want this module to use an ssh public key to create a new key pair in AWS specific the corresponding ssh public key here (in PEM format)."
  type        = string
  default     = null
}

variable "ssh_public_key_name" {
  description = "Specific the name of an existing AWS key pair if you want to use an existing one."
  type        = string
  default     = null
}

variable "tags" {
  type    = map
  default = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "iam_instance_profile" {
  type    = string
  default = null
}