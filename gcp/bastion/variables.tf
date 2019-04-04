variable "name" {
  description = "Bastion host name"
}

variable "project" {
  description = "Project where the elk stack instance will be created"
}

variable "network_project" {
  description = "Project where the elk stack subnetwork will be created"
}

variable "machine_type" {
  description = "machine type"
  default     = "f1-micro"
}

variable "zone" {
  description = "GCE zone"
}

variable "list_of_tags" {
  type        = "list"
  description = "Network tag list"
  default     = ["bastion", "gce"]
}

variable "image" {
  description = "OS image"
  default     = "debian-cloud/debian-9"
}

variable "disk_type" {
  description = "Disk type - [pd-standard pd-ssd]"
  default     = "pd-standard"
}

variable "disk_size" {
  description = "Disk size"
  default     = "10"
}

variable "network" {
  description = "The VPC where the elk-stack instance will be created"
  default     = "default"
}

variable "subnetwork" {
  description = "The VPC subnetwork where the elk-stack instance will be created"
  default     = "default"
}

variable "hostname" {
  description = "instance FQDN hostname"
}
