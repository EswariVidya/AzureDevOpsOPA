package azurerules

import input as tfplan
default allow  = false
allow = true{
    count(nsg_inbound_22) == 0
}

nsg_rule = false {
    count(nsg_inbound_22) !=0
}

nsg_inbound_22[resource_name] {
    nsg_rules1 := tfplan[_]
    resource_name := nsg_rules1.address
    nsg_rules1.type == "azurerm_network_security_group"
    #nsg_rules1.change.after.security_rule[_].access == "allow"
    nsg_rules1.change.after.security_rule[_].destination_port_range == "22"
    nsg_rules1.change.after.security_rule[_].direction == "Inbound"
}

storage_account_https = false {
    count(sa_https) != 0
}
sa_https[resource_name] {
    sa_https_access := tfplan[_]
    resource_name := sa_https_access.address
    sa_https_access.type == "azurerm_storage_account"
    sa_https_access.change.after.enable_https_traffic_only == false
}
