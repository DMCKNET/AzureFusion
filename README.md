# AzureFusion
A project to design a hybrid networking environment using Azure's networking capabilities. This project set up a robust and scalable Azure infrastructure using Terraform, providing a foundation for secure and efficient network management.

### Project Overview

I designed a hybrid networking environment where on-premises networks connected securely to Azure resources using Azure's networking capabilities, ensuring secure data transition and effective resource access controls. This project involved setting up a comprehensive Azure infrastructure using Terraform. The key components included creating virtual networks, subnets, public IPs, VPN gateways, local network gateways, and establishing VPN connections. Additionally, I configured Private DNS Zones and other necessary network resources.

![AzureFusion Architecture](images/AzureFusionDiagram.png)

### Technologies Used

**Terraform**
- **Azure Resource Manager (ARM)**
- **Azure Virtual Network**
- **Azure VPN Gateway**
- **Network Security Groups (NSGs)**
- **Azure Bastion**
- **Azure Private Link**
- **Azure DNS**
- **Azure Load Balancer**
- **Azure SQL Database**
- **Azure Storage Account**
- **Azure Key Vault**
- **Azure Monitor**
- **Azure Security Center**

### Steps Taken

#### Azure Virtual Network Setup

- **Provisioned an Azure Virtual Network (VNet)**: Created a VNet in the chosen region with multiple subnets (e.g., WebApp Subnet, Database Subnet, Admin Subnet, Gateway Subnet, Bastion Subnet) to segregate resources effectively.

#### On-Premises Network Simulation

- **Simulated On-Premises Environment**: Used another VNet to simulate the on-premises environment.

#### Secure Connectivity

- **Implemented Azure VPN Gateway**: Created a site-to-site VPN connection between the simulated on-premises VNet and the main Azure VNet. Verified the connection to ensure seamless communication between VNets, simulating a hybrid environment.

#### Resource Deployment

- **Deployed Test Resources**: Deployed virtual machines (VMs) in the WebApp Subnet of the main Azure VNet. Examples included two web server VMs in the WebApp Subnet and a database in the Database Subnet.

#### Network Access Control

- **Configured Network Security Groups (NSGs)**: Defined inbound and outbound access rules for each subnet to allow only valid traffic, such as HTTP/HTTPS traffic to the WebApp Subnet.

#### Secure Administrative Access

- **Implemented Azure Bastion**: Enabled secure RDP and SSH access to VMs without exposing them to the public internet using Azure Bastion.

#### Private Access to Azure PaaS Services

- **Used Azure Private Link**: Configured private endpoints within the VNet to access Azure PaaS services (e.g., Azure SQL Database) securely, ensuring data did not traverse the public internet.

#### DNS and Load Balancing

- **Configured Azure DNS**: Set up custom domain names for resources using Azure DNS.
- **Implemented Azure Load Balancer**: Distributed traffic across VMs in the WebApp Subnet using Azure Load Balancer.

#### Azure Key Vault Integration

- **Stored Secrets in Azure Key Vault**: Stored sensitive information such as admin usernames and passwords in Azure Key Vault.
- **Configured Access to Key Vault**: Ensured that the service principal has the necessary permissions to access secrets in the Key Vault.

#### Monitoring and Security

- **Set Up Azure Monitor**: Configured Azure Monitor to collect metrics and set up alerts for resource monitoring.
- **Enabled Azure Security Center**: Enabled the free tier of Azure Security Center for basic security features and continuous assessment.

### Security and Compliance

#### Alignment with NIST SP 800-53

This project aligns with several key controls from the NIST SP 800-53 framework, including:

- **Access Control (AC)**: Implemented Network Security Groups (NSGs) and Azure Bastion for secure access.
- **Audit and Accountability (AU)**: Configured Azure Monitor and Log Analytics for centralized logging and monitoring.
- **Configuration Management (CM)**: Used Terraform for consistent and repeatable infrastructure configurations.
- **Identification and Authentication (IA)**: Utilized Azure Key Vault for secure storage of sensitive information.
- **System and Communications Protection (SC)**: Established secure site-to-site VPN connections and private endpoints.
- **System and Information Integrity (SI)**: Enabled Azure Security Center for continuous security assessment and recommendations.

#### Zero Trust Architecture

The project also adheres to Zero Trust Architecture principles:

- **Verify Explicitly**: Ensured secure access to VMs using Azure Bastion and defined explicit NSG rules.
- **Use Least Privilege Access**: Restricted access to necessary traffic only and controlled access to sensitive information using Azure Key Vault.
- **Assume Breach**: Configured continuous monitoring and alerting with Azure Monitor and Security Center, and used secure communication channels like VPN Gateway and Private Link.

#### Performance and Security Testing

- **Simulated Network Scenarios**: Tested performance by simulating various network scenarios, such as data transition between on-premises and Azure.
- **Validated Security Configurations**: Attempted to access resources from unauthorized paths to ensure security configurations were effective.