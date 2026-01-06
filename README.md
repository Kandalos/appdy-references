# Enterprise Observability with AppDynamics

This repository serves as a comprehensive technical hub for deploying, configuring, and automating **AppDynamics** on Ubuntu Server environments. It transitions from **manual baseline installations** to **automated, self-healing infrastructure** using Terraform and Ansible.

## 🏗️ Core Components

An AppDynamics deployment consists of three mission-critical components that work in tandem to provide full-stack visibility.

| Component | Responsibility | Status |
| --- | --- | --- |
| **Controller & Console** | The central management hub and UI for all telemetry data. | ✅ [Manual Guide](https://www.google.com/search?q=docs/Controller_Installation.md) |
| **Events Service** | A high-performance analytics store for logs and transaction data. | ✅ [Manual Guide](https://www.google.com/search?q=docs/Events_Service.md) |
| **EUM Server** | Processor for End User Monitoring (Browser & Mobile) telemetry. | ✅ [Manual Guide](https://www.google.com/search?q=docs/EUM_Server.md) |

---

## 📂 Documentation Library

Navigate through the detailed installation and troubleshooting guides below:

* **[Controller & Console Setup](https://github.com/Kandalos/appdynamics/blob/main/docs/controller-setup-guide.md):** Learn how to prepare Ubuntu, manage `libaio` dependencies, and initialize the Enterprise Console.
* **[Events Service Cluster](https://github.com/Kandalos/appdynamics/blob/main/docs/controller-setup-guide.md):** Configuration for analytics nodes, including SSH credential management and Linux user limits.
* **[EUM Processor Deployment](https://github.com/Kandalos/appdynamics/blob/main/docs/eum-server-setup-guide.md):** Setup for the End User Monitoring server, JVM heap tuning, and Geo-IP database extraction.
* **[General Troubleshooting](https://github.com/Kandalos/appdynamics/blob/main/docs/trouble-shooting.md):** A collection of "Battle Scars"—real-world issues encountered during deployment and their fixes.

---

## 🛠️ The Roadmap: From Manual to Autonomous

I am currently in the **"Stability & Validation"** phase—running these manual setups across multiple infrastructures to identify edge cases and persistent errors.

1. **Phase 1: Manual Mastery** (Current)
* Hardening OS requirements and documentation accuracy.
* Testing across different Ubuntu versions.


2. **Phase 2: CI/CD & Infrastructure as Code** (Upcoming)
* Automating VM provisioning with **Terraform**.
* Standardizing configurations with **Ansible Playbooks**.


3. **Phase 3: Self-Healing AIOps** (Final Goal)
* Implementing **Event-Driven Ansible** to automatically resolve service failures or disk-full alerts detected by AppDynamics.



---

## ⚖️ License

This project is for educational and portfolio purposes. AppDynamics is a registered trademark of Cisco Systems.
