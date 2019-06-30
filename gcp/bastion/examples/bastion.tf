module "bastion" {
  source          = "github.com/kaysal/modules.git//gcp/bastion"
  name            = "bastion"
  hostname        = ""
  project         = var.project_id
  network_project = var.network_project_id
  network         = var.network_self_link
  subnetwork      = var.subnetwork_self_link
  zone            = "europe-west1-c"
  ssh_keys        = "user:${file(var.public_key_path)}"
  network_tier    = "STANDARD"
  tags            = ["bastion", "gce"]
  service_account_email = data.terraform_remote_state.host.outputs.vm_host_project_service_account_email
}
