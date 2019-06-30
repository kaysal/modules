
module "web" {
  source          = "github.com/kaysal/modules.git//gcp/gce-public"
  name            = "web"
  hostname        = ""
  project         = var.project_id
  network_project = var.network_project_id
  network         = var.network_self_link
  subnetwork      = var.subnetwork_self_link
  network_ip      = "10.100.10.101"
  zone            = "europe-west1-b"
  tags            = ["gce"]

  metadata_startup_script = "${file("scripts/startup.sh")}"
  service_account_email   = var.service_account_email
}
