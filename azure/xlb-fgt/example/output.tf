output "ilb_private-ip"{
  value = module.lb.ilb_private-ip
}

output "elb_public-ip"{
  value = module.lb.elb_public-ip
}

output "gwlb_frontip_config_id"{
  value = module.lb.gwlb_frontip_config_id
}

