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

storage_account = false {
    count(storage_account_access) != 0
}
storage_account_access[resource_name] {
    sa_access := tfplan[_]
    resource_name := sa_access.address
    sa_access.type == "azurerm_storage_account"
    sa_access.change.after.network_rules[_].default_action == "Allow"
}
