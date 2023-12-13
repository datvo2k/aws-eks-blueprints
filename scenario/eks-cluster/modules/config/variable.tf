# create some variables
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "cluster_endpoint" {
  type        = string
  description = "Endpoint for your Kubernetes API server."
}

variable "cluster_certificate_authority_data" {
  type        = string
  description = "Base64 encoded certificate data required to communicate with the cluster."
}

variable "spot_termination_handler_chart_name" {
  type        = string
  description = "EKS Spot termination handler Helm chart name."
}

variable "spot_termination_handler_chart_repo" {
  type        = string
  description = "EKS Spot termination handler Helm repository name."
}

variable "spot_termination_handler_chart_version" {
  type        = string
  description = "EKS Spot termination handler Helm chart version."
}

variable "spot_termination_handler_chart_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
}

# create some variables
variable "external_dns_iam_role" {
  type        = string
  description = "IAM Role Name associated with external-dns service."
}

variable "external_dns_chart_name" {
  type        = string
  description = "Chart Name associated with external-dns service."
}

variable "external_dns_chart_repo" {
  type        = string
  description = "Chart Repo associated with external-dns service."
}

variable "external_dns_chart_version" {
  type        = string
  description = "Chart Repo associated with external-dns service."
}

variable "external_dns_values" {
  type        = map(string)
  description = "Values map required by external-dns service."
}

variable "dns_base_domain" {
  type        = string
  description = "DNS Zone name to be used from EKS Ingress."
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}

variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
}

variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}

variable "dns_base_domain" {
  type        = string
  description = "DNS Zone name to be used from EKS Ingress."
}

variable "ingress_gateway_name" {
  type        = string
  description = "Load-balancer service name."
}

variable "ingress_gateway_iam_role" {
  type        = string
  description = "IAM Role Name associated with load-balancer service."
}

variable "ingress_gateway_chart_name" {
  type        = string
  description = "Ingress Gateway Helm chart name."
}

variable "ingress_gateway_chart_repo" {
  type        = string
  description = "Ingress Gateway Helm repository name."
}

variable "ingress_gateway_chart_version" {
  type        = string
  description = "Ingress Gateway Helm chart version."
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to be created in our EKS Cluster."
}


