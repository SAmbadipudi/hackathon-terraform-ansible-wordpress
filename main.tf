provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
  profile = "default"
}

### Instance Creation #####
resource "aws_instance" "hack_app" {
        ami = "${var.ami}"
        instance_type = "${var.instance_type}"
	count = 1
        tags {
                Role = "app"
		Name = "${format("application-%01d",count.index+1)}"
        }
        key_name = "${var.key_name}"
        vpc_security_group_ids = ["${var.sg_ids}"]
	subnet_id = "${var.subnet_ids}"
	associate_public_ip_address = "true"

}
#resource "aws_instance" "hack_DB" {
#        ami = "${var.ami}"
#        instance_type = "${var.instance_type}"
#        count = 1
#        tags {
#		Role = "db"
#                Name = "${format("database-%01d",count.index+1)}"
#        }
#        key_name = "${var.key_name}"
#        vpc_security_group_ids = ["${var.sg_ids}"]
#        subnet_id = "${var.subnet_ids}"
#        associate_public_ip_address = "true"
#}

# Executing Ansible playbook post of infrastructure

resource "null_resource" "AnsiblePlaybook" {
  depends_on = ["aws_instance.hack_app"]
  provisioner "local-exec" {
    command = "sleep 60;ansible-playbook --inventory-file=terraform-inventory /home/ec2-user/terraform_script/playbooks/main.yml -vvvv"
  }
}
