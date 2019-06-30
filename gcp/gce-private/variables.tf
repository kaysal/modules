variable "name" {
  description = "vm host name"
}

variable "project" {
  description = "Project where the elk stack instance will be created"
}

variable "network_project" {
  description = "Project where the elk stack subnetwork will be created"
  default = null
}

variable "machine_type" {
  description = "machine type"
  default     = "f1-micro"
}

variable "zone" {
  description = "GCE zone"
}

variable "tags" {
  type        = list(string)
  description = "Network tag list"
  default     = []
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

variable "network_ip" {
  description = "The private IP address to assign to the instance"
  default     = null
}

variable "hostname" {
  description = "instance FQDN hostname"
  default     = null
}

variable "ssh_keys" {
  description = "SSH public keys for VM"
  default     = null
}

variable "service_account_email" {
  description = "VM service account email"
  default     = null
}

variable "scopes" {
  description = <<EOF
  "A list of service scopes.
  Both OAuth2 URLs and gcloud short names are supported.
  To allow full access to all Cloud APIs, use the cloud-platform scope"
EOF

  default = ["cloud-platform"]
}

variable "metadata_startup_script" {
  description = "VM instance metadata start-up script"
  default = null
}
