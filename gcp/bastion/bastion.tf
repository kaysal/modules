# Bastion host
#============================
data "template_file" "bastion_init" {
  template = "${file("${path.module}/scripts/bastion.sh.tpl")}"

  vars {
    VAR = "value"
  }
}

resource "google_compute_instance" "bastion" {
  name                      = "${var.name}"
  hostname                  = "${var.hostname}"
  machine_type              = "${var.machine_type}"
  zone                      = "${var.zone}"
  tags                      = "${var.list_of_tags}"
  allow_stopping_for_update = true
  can_ip_forward            = true

  boot_disk {
    initialize_params {
      image = "${var.image}"
      type  = "${var.disk_type}"
      size  = "${var.disk_size}"
    }
  }

  network_interface {
    subnetwork_project = "${var.network_project}"
    subnetwork         = "${var.subnetwork}"
    access_config      = {}
  }

  metadata_startup_script = "${data.template_file.bastion_init.rendered}"

  service_account {
    scopes = ["cloud-platform"]
  }
}
