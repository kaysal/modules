
# bastion host

locals {
  bastion_init = templatefile("${path.module}/scripts/bastion.sh.tpl", {
    VAR = "value"
  })
}

resource "google_compute_instance" "bastion" {
  name                      = var.name
  hostname                  = var.hostname
  machine_type              = var.machine_type
  zone                      = var.zone
  tags                      = var.tags
  allow_stopping_for_update = true
  can_ip_forward            = true

  boot_disk {
    initialize_params {
      image = var.image
      type  = var.disk_type
      size  = var.disk_size
    }
  }

  network_interface {
    subnetwork_project = var.network_project
    subnetwork         = var.subnetwork

    access_config {
      nat_ip       = var.nat_ip
      network_tier = var.network_tier

      public_ptr_domain_name = var.public_ptr_domain_name
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  metadata_startup_script = local.bastion_init

  service_account {
    scopes = var.scopes
    email  = var.service_account_email
  }
}