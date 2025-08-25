# 🐝 Honeycluster — Kubernetes Honeypot with vcluster, Falco, and NGINX

![License](https://img.shields.io/github/license/arnavtripathy/honeycluster)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28+-blue?logo=kubernetes)
![Falco](https://img.shields.io/badge/Falco-Security-orange?logo=falco)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

**Honeycluster** is a lightweight, modular Kubernetes honeypot system that leverages **vcluster** for safe isolation, **Falco** for runtime threat detection, **NGINX** for simulating an exposed Kubernetes API server, and **Falcosidekick** for unified alert forwarding.  

The system is designed to **attract**, **detect**, and **log** malicious activity in a controlled environment — enabling researchers, SOC teams, and security engineers to study attacker behavior without risking production infrastructure.

---

## 📜 Features

- **Deception Through Realism**
  - Simulates a Kubernetes control plane with `vcluster` in a dedicated namespace.
  - Deploys vulnerable workloads and intentionally insecure configurations (e.g., anonymous API access).

- **Runtime Threat Detection**
  - Uses **Falco** to monitor system calls, detect shell spawns, privilege escalation, and suspicious binaries.
  - Includes custom Falco rules tuned for honeypot context.

- **Unified Logging Pipeline**
  - **NGINX reverse proxy** intercepts fake Kubernetes API requests and formats them as JSON logs.
  - Logs and alerts forwarded to **Falcosidekick** and then to webhooks/dashboards.

- **Safe Isolation**
  - Runs inside `minikube` or any Kubernetes cluster.
  - Restricts honeypot namespace network access via NetworkPolicies.

---

## 🛠 Tools and Components

| Component | Purpose |
|-----------|---------|
| [vcluster](https://www.vcluster.com/) | Creates a virtual Kubernetes cluster inside a namespace for isolation |
| [Falco](https://falco.org/) | Syscall-based runtime security detection |
| [Falcosidekick](https://github.com/falcosecurity/falcosidekick) | Forwards Falco alerts to multiple outputs |
| [NGINX](https://nginx.org/) | Simulates exposed Kubernetes API and logs requests |
| [Helm](https://helm.sh/) | Simplified deployments of vcluster, Falco, and Falcosidekick |
| [Minikube](https://minikube.sigs.k8s.io/) | Local Kubernetes cluster for testing |

---

## 🏗 Architecture

Below is the high-level architecture of **Honeycluster**:

![Honeycluster Architecture](honeyarch.png)


## 📦 Deployment Guide

### 1️⃣ Prerequisites
- Kubernetes cluster (Minikube or cloud-based)
- [Helm](https://helm.sh/) installed
- `kubectl` configured

### 2️⃣ Deploy vcluster with Insecure API
` vcluster create honeypot -n honeypot -f vcluster_values_yaml/vcluster-api.yaml `
The values file is deliberately configured with the API server set to [anonymous mode](https://securitylabs.datadoghq.com/cloud-security-atlas/vulnerabilities/unauthenticated-api-server/) misconfig. You can modify values.yaml further to add more misconfigurations.

` kubectl apply -f vcluster_values_yaml/anonymous-policy.yaml` to deploy the policy for anonymous mode. Currently it allows every request to kube api in anonymous. You can configure accordingly

### Deploy Vulnerable Workloads

The `vulnerable_workloads` folder contains some sample vulnerable workloads which you can deploy . You can configure accordingly. To deploy them:

` kubectl apply -f vulnerable_workloads/`





