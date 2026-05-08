variable "components" {
  default = {
    catalogue = {      #Key = catalogue ; Value = rule_priority
        rule_priority = 10
    }
    user = {
        rule_priority = 20
    }
    cart = {
        rule_priority = 30
    }
    shipping = {
        rule_priority = 40
    }
    payment = {
        rule_priority = 50
    }
  }
}