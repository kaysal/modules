# GKE cluster

Creating a GKE cluster.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | Cluster name. | string | n/a | yes |
| enable\_private_endpoint | Master's internal IP as cluster endpoint? | string | false | yes |
| enable\_private_nodes | nodes have only internal IP? | string | n/a | yes |
| network | Cluster network | string | n/a | yes |
| pods\_range | Name of the alias IP range for pods | string | n/a | yes |
| services\_range | Name of the alias IP range for services | string | n/a | yes |
| project\_id | Cluster project | string | n/a | yes |
| region | Cluster region | string | n/a | yes |
| subnetwork | Cluster subnetwork | string | n/a | yes |
| zones | Cluster zones | list | n/a | yes |
| cluster\_labels | Labels to be attached to the cluster | map | `<map>` | no |
| node\_labels | Labels to be attached to the node | map | `<map>` | no |
| min\_master\_version | Minimum version for master | string | `"1.11.8-gke.6"` | no |
| network\_policy\_enabled | network policy enabled on cluster? | string | `"false"` | no |
| network\_tags | Network tags attached to cluster VMs | list | `<list>` | no |
| node\_count | Initial node count | string | `"1"` | no |
| oauth\_scopes | Scopes for the nodes service account | list | `<list>` | no |
| service\_account | Service account for nodes | string | `"default"` | no |
| machine\_type | Node machine type | string | `"n1-standard-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_ca\_certificate |  |
| endpoint |  |
| master\_version |  |
| name |  |
| region |  |
| unique\_id |  |

## Example Usage

```
module "gke" {
  source     = "../../../../../../../tf_modules/gcp/gke"
  project_id = "${data.terraform_remote_state.gke.gke_service_project_id}"

  # cluster
  name                           = "${var.cluster_name}"
  enable_private_endpoint        = false
  enable_private_nodes           = true
  master_ipv4_cidr_block         = "172.16.0.0/28"
  min_master_version             = "1.11.8-gke.6"
  network                        = "${var.network}"
  subnetwork                     = "${var.subnetwork}"
  pods_range_name                = "pod-range"
  services_range_name            = "svc-range"
  location                       = "europe-west1"
  default_max_pods_per_node      = 16
  remove_default_node_pool       = true
  logging_service                = "logging.googleapis.com/kubernetes"
  monitoring_service             = "monitoring.googleapis.com/kubernetes"
  enable_binary_authorization    = false
  network_policy_enabled         = true
  network_policy_config_disabled = false
  kubernetes_dashboard_disabled  = false
  istio_config_disabled          = false

  cluster_labels = {
    component = "gke"
  }

  # node
  node_count      = 1
  machine_type    = "n1-standard-2"
  service_account = "default"
  network_tags    = ["gke"]
  node_metadata   = "SECURE

  node_labels = {
    component = "gke"
  }

  oauth_scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
  ]
}
```

## Sample Output

TODO: add sample output here
