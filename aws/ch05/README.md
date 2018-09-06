<!-- page_number: true -->

# CH05 EKS

--- 

## EKS Cluster
- repo: [GitHub - getamis/vishwakarma](https://github.com/getamis/vishwakarma)

### Modules
- path: `vishwakarma/aws`
- modules :
    - network
    - container_linux
    - eks
--- 

- directories:

```
├── container_linux
├── eks
│   ├── ignition
│   │   └── resources
│   │       ├── dropins
│   │       ├── kubernetes
│   │       ├── services
│   │       └── sysctl.d
│   ├── master
│   │   └── resources
│   ├── worker-asg
│   ├── worker-common
│   └── worker-spot
└── network
```

---

- module: `vishwakarma/aws/eks/master`
- files:
```
└── master
    ├── aws-auth-cm.tf
    ├── cluster.tf
    ├── main.tf
    ├── outputs.tf
    ├── resources
    │   ├── aws-auth-cm.yaml.tpl
    │   └── kubeconfig
    ├── role.tf
    ├── s3.tf
    ├── sg.tf
    └── variables.tf
```

---

## Resources

- Kubernetes Master
  - VPC
  - IAM Roles

- Kubernetes Worker Node
  - worker-common
  - worker-asg
    - AutoScaling Group containing 2 m4.large instances

---

## Preparation
- If you are planning to locally use the standard Kubernetes client, kubectl, it must be at least version 1.10 to support exec authentication with usage of aws-iam-authenticator. 

### Kubernetes Client Install Guide
- https://kubernetes.io/docs/tasks/tools/install-kubectl/

### AWS IAM Authenticator
- https://github.com/kubernetes-sigs/aws-iam-authenticator

--- 

## Variables
- Cluster Name 

--- 

## Base VPC Networking
- One VPC
  - One Public Subnet
  - One Private Subnet
  -  an internet gateway, and setup the subnet routing to route external traffic through the internet gateway:

- Bastion is a `jump server`
- https://docs.aws.amazon.com/quickstart/latest/linux-bastion/architecture.html

--- 

## Kubernetes Master
- This is where the EKS service comes into play. 
- It requires a few operator managed resources beforehand so that Kubernetes can properly manage other AWS services.


---

### Example
- path: `vishwakarma/examples/eks_worker`
- `main.tf`

#### network 
- code:
```
module "network" {
  source           = "../../aws//network"
  aws_region       = "${var.aws_region}"
  bastion_key_name = "${var.key_pair_name}"
}
```

--- 

## Kubernetes Master
- This is where the EKS service comes into play. 
- need
  - VPC
  - IAM
  - SecurityGroup

---

### IAM Roles
- `aws_iam_role`
- `aws_iam_policy_document`
- `aws_iam_role_policy_attachment`
  - `AmazonEKSClusterPolicy`
  - `AmazonEKSServicePolicy`
- `aws/eks/master/role-eks.tf`

---

### EKS Master Cluster Security Group
- `aws_security_group`
- `aws_security_group_rule`
  - `egress` 
  - `ingress_https`
- `aws/eks/master/security-group-eks.tf`

---

### EKS Master Cluster
- `aws_eks_cluster`
- depends_on
- `aws/eks/master/cluster.tf`

---

### Obtaining kubectl Configuration From Terraform
- kubeconfig
- `aws_s3_bucket`
  - `template_file`
  - `aws_s3_bucket_object`
- `local_file`
- `aws/eks/master/s3-kubeconfig.tf`

---

### Required Kubernetes Configuration to Join Worker Nodes

- `aws/eks/master/aws-auth-cm.tf`

- The EKS service does not provide a cluster-level API parameter or resource to automatically configure the underlying Kubernetes cluster to allow worker nodes to join the cluster via AWS IAM role authentication.

- To output an example IAM Role authentication ConfigMap from your Terraform configuration


---

## Kubernetes Worker Nodes
- worker_common
  - Initailization of EC2 Instance
- wroker_asg
  - Preparation for added into Kubernetes Cluster

---

### Worker Node IAM Role and Instance Profile
- `aws/eks/worker-common/role.tf`
- `aws_iam_role`
- `aws_iam_role_policy_attachment`
  - `AmazonEKSWorkerNodePolicy`
  - `AmazonEKS_CNI_Policy`
  - `AmazonEC2ContainerRegistryReadOnly`
- `aws_iam_instance_profile`

---

### Worker Node Security Group

- `aws/eks/master/security-group-worker.tf`
- `aws_security_group`
- `aws_security_group_rule`
  - `workers_egress_internet`
  - `workers_ingress_self`
  - `workers_ingress_cluster`
  - `workers_ingress_ssh`
  - `worker_ingress_lb`

---

### Ｗorker Node AutoScaling Group
- This setup utilizes an EC2 AutoScaling Group (ASG) rather than manually working with EC2 instances. 
- This offers flexibility to scale up and down the worker nodes on demand.
- `aws/eks/worker-asg/asg.tf`

---

### AMI
- First, let us create a data source to fetch the latest Amazon Machine Image (AMI) that Amazon provides with an EKS compatible Kubernetes baked in.
- `aws/eks/worker-asg/asg.tf`
  - `aws_autoscaling_group`
    - `aws_launch_configuration`
      - `aws_launch_configuration`
        - `image_id             = "${coalesce(var.ec2_ami, module.worker_common.coreos_ami_id)}"`

---

### AMI for module
- `module.worker_common.coreos_ami_id`
- `aws/eks/worker-common/ami.tf`
- ``module.container_linux`
  - try to get latest version of coreos, if needed
```
data "aws_ami" "coreos_ami" {
  filter {
    name   = "name"
    values = ["CoreOS-${var.container_linux_channel}-${module.container_linux.version}-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-id"
    values = ["${local.ami_owner}"]
  }
}
```
---

###  AutoScaling Launch Configuration
- `aws/eks/worker-asg/asg.tf`
  - `aws_autoscaling_group`
    - `aws_launch_configuration`

```
resource "aws_launch_configuration" "workers" {
......
  user_data            = "${module.worker_common.ign_config_rendered}"

......
}

```

---

###  User Data - ignition
- Ignition is a new provisioning utility designed specifically for CoreOS Container Linux. 
- https://coreos.com/ignition/docs/latest/

- `aws/eks/ignition`
- `aws/eks/worker_common/ignition`
  - locksmithd
  - docker
  - ca
  - heptio_authenticator_aws
  - kubelet

```
data "ignition_config" "main" {
  files = ["${compact(list(
    module.ignition_worker.max_user_watches_id,
    module.ignition_worker.ntp_dropin_id,
    module.ignition_worker.client_ca_file_id,
    module.ignition_worker.kubeconfig_id,
    module.ignition_worker.kubelet_env_id,
   ))}"
  ]

  systemd = [
    "${module.ignition_worker.locksmithd_service_id}",
    "${module.ignition_worker.docker_dropin_id}",
    "${module.ignition_worker.update_ca_certificates_dropin_id}",
    "${module.ignition_worker.heptio_authenticator_aws_id}",
    "${module.ignition_worker.kubelet_service_id}",
  ]
}

```

---


### AutoScaling Launch Configuration

```
  lifecycle {
    create_before_destroy = true

    # Ignore changes in the AMI which force recreation of the resource. This
    # avoids accidental deletion of nodes whenever a new CoreOS Release comes
    # out.
    ignore_changes = ["image_id"]
  }
```

--- 
