# vm host

resource "google_compute_instance" "vm" {
  name         = var.name
  hostname     = var.hostname
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

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
    network_ip         = var.network_ip
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  metadata_startup_script = var.metadata_startup_script

  service_account {
    scopes = var.scopes
    email  = var.service_account_email
  }
}
