# terraform-splunk

vim ~/.aws/credentials

[default]

access_key= secret_key=

export AWS_DEFAULT_PROFILE=profile_name

Also

ssh-agent bash
ssh-add ~/.ssh/id_rsa
Install Terraform

https://www.terraform.io/intro/getting-started/install.html

Clone this repo:

you can run "terraform plan" command to see what will terraform will deploy to AWS.

```
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.aws_availability_zones.available: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_default_route_table.splunk_private_rt
      id:                                          <computed>
      default_route_table_id:                      "${aws_vpc.splunk_vpc.default_route_table_id}"
      route.#:                                     <computed>
      tags.%:                                      "1"
      tags.Name:                                   "splunk_private"
      vpc_id:                                      <computed>

  + aws_instance.splunk_prod
      id:                                          <computed>
      ami:                                         "ami-b73b63a0"
      associate_public_ip_address:                 <computed>
      availability_zone:                           <computed>
      ebs_block_device.#:                          <computed>
      ephemeral_block_device.#:                    <computed>
      get_password_data:                           "false"
      instance_state:                              <computed>
      instance_type:                               "t2.micro"
      ipv6_address_count:                          <computed>
      ipv6_addresses.#:                            <computed>
      key_name:                                    "${aws_key_pair.splunk_auth.id}"
      network_interface.#:                         <computed>
      network_interface_id:                        <computed>
      password_data:                               <computed>
      placement_group:                             <computed>
      primary_network_interface_id:                <computed>
      private_dns:                                 <computed>
      private_ip:                                  <computed>
      public_dns:                                  <computed>
      public_ip:                                   <computed>
      root_block_device.#:                         <computed>
      security_groups.#:                           <computed>
      source_dest_check:                           "true"
      subnet_id:                                   "${aws_subnet.splunk_public1_subnet.id}"
      tags.%:                                      "1"
      tags.Name:                                   "splunk_prod"
      tenancy:                                     <computed>
      user_data:                                   "0151761d4077412c243a88f65faba8d5f05a4a32"
      volume_tags.%:                               <computed>
      vpc_security_group_ids.#:                    <computed>

  + aws_internet_gateway.splunk_internet_gateway
      id:                                          <computed>
      tags.%:                                      "1"
      tags.Name:                                   "splunk_igw"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_key_pair.splunk_auth
      id:                                          <computed>
      fingerprint:                                 <computed>
      key_name:                                    "ahsan"
      public_key:                                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSbbfHq/ei3jwgUmjiazSGvwpPt9Gpa/52BByB3QF5fNm3h6IQdLqkH5iaAes0RYHLgIEpvO7Mcj22dC7hHMlCSjia8WBEvi5Hear9zSZPf4K+7Qnl7KYV5r9ZZjJEGuBB/lsdJkK6643JgayAdSLH6qzkd/Obv91ZWIr0AmUQHfGuBmoqWH1kNx1IK8PZbG4JbcLMVoowKNc6OyebX02vRNg+90oM9+u4NePOWkDjKDkgSyqmQry8OcSh95HdBMUPM7w65NiAiubtEaC+n40swkK7WAvVkEtgYkeXIhhoV3lgKzNaojyq9WfZ0FipNjCRrheyVOBPROTsYTaeXayf ajaved@ajaved-MBP-459FF"

  + aws_route_table.splunk_public_rt
      id:                                          <computed>
      propagating_vgws.#:                          <computed>
      route.#:                                     "1"
      route.~3798642566.cidr_block:                "0.0.0.0/0"
      route.~3798642566.egress_only_gateway_id:    ""
      route.~3798642566.gateway_id:                "${aws_internet_gateway.splunk_internet_gateway.id}"
      route.~3798642566.instance_id:               ""
      route.~3798642566.ipv6_cidr_block:           ""
      route.~3798642566.nat_gateway_id:            ""
      route.~3798642566.network_interface_id:      ""
      route.~3798642566.vpc_peering_connection_id: ""
      tags.%:                                      "1"
      tags.Name:                                   "splunk_public"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_route_table_association.splunk_private1_assoc
      id:                                          <computed>
      route_table_id:                              "${aws_default_route_table.splunk_private_rt.id}"
      subnet_id:                                   "${aws_subnet.splunk_private1_subnet.id}"

  + aws_route_table_association.splunk_private2_assoc
      id:                                          <computed>
      route_table_id:                              "${aws_default_route_table.splunk_private_rt.id}"
      subnet_id:                                   "${aws_subnet.splunk_private2_subnet.id}"

  + aws_route_table_association.splunk_public1_assoc
      id:                                          <computed>
      route_table_id:                              "${aws_route_table.splunk_public_rt.id}"
      subnet_id:                                   "${aws_subnet.splunk_public1_subnet.id}"

  + aws_route_table_association.splunk_public2_assoc
      id:                                          <computed>
      route_table_id:                              "${aws_route_table.splunk_public_rt.id}"
      subnet_id:                                   "${aws_subnet.splunk_public2_subnet.id}"

  + aws_security_group.splunk_private_sg
      id:                                          <computed>
      arn:                                         <computed>
      description:                                 "Used for private instances"
      egress.#:                                    "1"
      egress.482069346.cidr_blocks.#:              "1"
      egress.482069346.cidr_blocks.0:              "0.0.0.0/0"
      egress.482069346.description:                ""
      egress.482069346.from_port:                  "0"
      egress.482069346.ipv6_cidr_blocks.#:         "0"
      egress.482069346.prefix_list_ids.#:          "0"
      egress.482069346.protocol:                   "-1"
      egress.482069346.security_groups.#:          "0"
      egress.482069346.self:                       "false"
      egress.482069346.to_port:                    "0"
      ingress.#:                                   "1"
      ingress.1960698028.cidr_blocks.#:            "1"
      ingress.1960698028.cidr_blocks.0:            "10.0.0.0/16"
      ingress.1960698028.description:              ""
      ingress.1960698028.from_port:                "0"
      ingress.1960698028.ipv6_cidr_blocks.#:       "0"
      ingress.1960698028.protocol:                 "-1"
      ingress.1960698028.security_groups.#:        "0"
      ingress.1960698028.self:                     "false"
      ingress.1960698028.to_port:                  "0"
      name:                                        "splunk_private_sg"
      owner_id:                                    <computed>
      revoke_rules_on_delete:                      "false"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_security_group.splunk_public_sg
      id:                                          <computed>
      arn:                                         <computed>
      description:                                 "Used for access to the prod instance"
      egress.#:                                    "1"
      egress.482069346.cidr_blocks.#:              "1"
      egress.482069346.cidr_blocks.0:              "0.0.0.0/0"
      egress.482069346.description:                ""
      egress.482069346.from_port:                  "0"
      egress.482069346.ipv6_cidr_blocks.#:         "0"
      egress.482069346.prefix_list_ids.#:          "0"
      egress.482069346.protocol:                   "-1"
      egress.482069346.security_groups.#:          "0"
      egress.482069346.self:                       "false"
      egress.482069346.to_port:                    "0"
      ingress.#:                                   "5"
      ingress.2214680975.cidr_blocks.#:            "1"
      ingress.2214680975.cidr_blocks.0:            "0.0.0.0/0"
      ingress.2214680975.description:              ""
      ingress.2214680975.from_port:                "80"
      ingress.2214680975.ipv6_cidr_blocks.#:       "0"
      ingress.2214680975.protocol:                 "tcp"
      ingress.2214680975.security_groups.#:        "0"
      ingress.2214680975.self:                     "false"
      ingress.2214680975.to_port:                  "80"
      ingress.2541437006.cidr_blocks.#:            "1"
      ingress.2541437006.cidr_blocks.0:            "0.0.0.0/0"
      ingress.2541437006.description:              ""
      ingress.2541437006.from_port:                "22"
      ingress.2541437006.ipv6_cidr_blocks.#:       "0"
      ingress.2541437006.protocol:                 "tcp"
      ingress.2541437006.security_groups.#:        "0"
      ingress.2541437006.self:                     "false"
      ingress.2541437006.to_port:                  "22"
      ingress.2617001939.cidr_blocks.#:            "1"
      ingress.2617001939.cidr_blocks.0:            "0.0.0.0/0"
      ingress.2617001939.description:              ""
      ingress.2617001939.from_port:                "443"
      ingress.2617001939.ipv6_cidr_blocks.#:       "0"
      ingress.2617001939.protocol:                 "tcp"
      ingress.2617001939.security_groups.#:        "0"
      ingress.2617001939.self:                     "false"
      ingress.2617001939.to_port:                  "443"
      ingress.332570261.cidr_blocks.#:             "1"
      ingress.332570261.cidr_blocks.0:             "0.0.0.0/0"
      ingress.332570261.description:               ""
      ingress.332570261.from_port:                 "8000"
      ingress.332570261.ipv6_cidr_blocks.#:        "0"
      ingress.332570261.protocol:                  "tcp"
      ingress.332570261.security_groups.#:         "0"
      ingress.332570261.self:                      "false"
      ingress.332570261.to_port:                   "8000"
      ingress.873884749.cidr_blocks.#:             "1"
      ingress.873884749.cidr_blocks.0:             "0.0.0.0/0"
      ingress.873884749.description:               ""
      ingress.873884749.from_port:                 "9997"
      ingress.873884749.ipv6_cidr_blocks.#:        "0"
      ingress.873884749.protocol:                  "tcp"
      ingress.873884749.security_groups.#:         "0"
      ingress.873884749.self:                      "false"
      ingress.873884749.to_port:                   "9997"
      name:                                        "splunk_public_sg"
      owner_id:                                    <computed>
      revoke_rules_on_delete:                      "false"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_subnet.splunk_private1_subnet
      id:                                          <computed>
      assign_ipv6_address_on_creation:             "false"
      availability_zone:                           "us-east-1a"
      cidr_block:                                  "10.0.3.0/24"
      ipv6_cidr_block:                             <computed>
      ipv6_cidr_block_association_id:              <computed>
      map_public_ip_on_launch:                     "false"
      tags.%:                                      "1"
      tags.Name:                                   "splunk_private1"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_subnet.splunk_private2_subnet
      id:                                          <computed>
      assign_ipv6_address_on_creation:             "false"
      availability_zone:                           "us-east-1b"
      cidr_block:                                  "10.0.4.0/24"
      ipv6_cidr_block:                             <computed>
      ipv6_cidr_block_association_id:              <computed>
      map_public_ip_on_launch:                     "false"
      tags.%:                                      "1"
      tags.Name:                                   "splunk_private2"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_subnet.splunk_public1_subnet
      id:                                          <computed>
      assign_ipv6_address_on_creation:             "false"
      availability_zone:                           "us-east-1a"
      cidr_block:                                  "10.0.1.0/24"
      ipv6_cidr_block:                             <computed>
      ipv6_cidr_block_association_id:              <computed>
      map_public_ip_on_launch:                     "true"
      tags.%:                                      "1"
      tags.Name:                                   "splunk_public1"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_subnet.splunk_public2_subnet
      id:                                          <computed>
      assign_ipv6_address_on_creation:             "false"
      availability_zone:                           "us-east-1b"
      cidr_block:                                  "10.0.2.0/24"
      ipv6_cidr_block:                             <computed>
      ipv6_cidr_block_association_id:              <computed>
      map_public_ip_on_launch:                     "true"
      tags.%:                                      "1"
      tags.Name:                                   "splunk_public2"
      vpc_id:                                      "${aws_vpc.splunk_vpc.id}"

  + aws_vpc.splunk_vpc
      id:                                          <computed>
      assign_generated_ipv6_cidr_block:            "false"
      cidr_block:                                  "10.0.0.0/16"
      default_network_acl_id:                      <computed>
      default_route_table_id:                      <computed>
      default_security_group_id:                   <computed>
      dhcp_options_id:                             <computed>
      enable_classiclink:                          <computed>
      enable_classiclink_dns_support:              <computed>
      enable_dns_hostnames:                        "true"
      enable_dns_support:                          "true"
      instance_tenancy:                            <computed>
      ipv6_association_id:                         <computed>
      ipv6_cidr_block:                             <computed>
      main_route_table_id:                         <computed>
      tags.%:                                      "1"
      tags.Name:                                   "splunk_vpc"


Plan: 16 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
if you want to deploy the above infrastructure then run the following command

$ terrraform apply

