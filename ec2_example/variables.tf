 variable "bkregion" {
   type = "string"
 }

# Declare lists implicitly by using brackets
variable "cidr_1" {
  default = []
}
# Declare lists explicitly using the list keyword
variable "cidr_2" {
  type = "list"
}
