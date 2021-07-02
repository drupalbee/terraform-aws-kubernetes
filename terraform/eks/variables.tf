variable "region" {
  type = string
}

variable "map_users" {
  description = "IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "node_group_on_demand_desired_capacity" {
  type = number
}

variable "node_group_on_demand_min_capacity" {
  type = number
}

variable "node_group_on_demand_max_capacity" {
  type = number
}

variable "node_group_on_demand_instance_types" {
  type = list(string)
}

variable "node_group_on_demand_capacity_type" {
  type = string
}

variable "project_name" {
  type = string
}
