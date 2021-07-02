region = "ap-southeast-1"

map_users = [
  {
    userarn  = "arn:aws:iam::369582615178:user/arjane"
    username = "admin"
    groups   = ["system:masters"]
  },
]

node_group_on_demand_desired_capacity = 1

node_group_on_demand_min_capacity = 1

node_group_on_demand_max_capacity = 1

node_group_on_demand_instance_types = ["t2.micro"]

node_group_on_demand_capacity_type = "SPOT"

