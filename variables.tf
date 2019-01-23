variable "access_key" {
  description = "The AWS access."
}

variable "secret_key" {
  description = "The AWS secret."
}

variable "region" {
  description = "The AWS region."
}

variable ami {
  description = "Instance AMI"
}

variable instance_type {
  description = "instance type"
  default     = "t2.micro"
}

variable key_name {
  description = "Name of ssh key to create"
}

variable sg_ids {
  description = "List of security groups ids"
}

variable subnet_ids {
  description = "List of security groups ids"
}

