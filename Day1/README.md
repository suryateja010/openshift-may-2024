# Day 1

## What is dual-booting or multi-booting?
- Let's say we have a laption with Windows 10 pre-installed
- I need to do some prototype in Ubuntu
- You can use a system utlity called Boot Loaders like LILO, Grub 1, Grub2
- When we install boot loaders it gets installed in your hard disk Master Boot Record(MBR) - Sector 0, Byte 0 in your hard disk (512 bytes)
- When we boot our machine, BIOS POST (Power On Self Test), once the BIOS is loaded, BIOS will initialize all hardwares and then it then it instructs the CPU to load and run the Boot loader application from MBR
- The boot application starts scanning for Operating Systems installed on your Hard disk(s), if it finds more than one OS then it gives a menu for you to choose which OS you wish to boot into
- Only one OS can be active at any point of time

## Virtualization Overview
- aka Hypervisor
- hardware + software technology
- Processors
  - AMD ( Virtualization Feature is called AMD-V )
  - Intel ( Virtualization Feature is called VT-X )
  - Apple Silicon (ARM Processor)
- through virtualization we can run multiple operating systems side by side on the same laptop/desktop/workstation/server
- many OS can be active on the same machine 
- Virtualization can be enabled/disabed on the BIOS level too
- you can install Hypervisor
- Examples
  - Oracle VirtualBox ( Type 2 -Windows, Mac OS-X, Linux, Free )
  - VMWare
    - Workstation ( Type 2 - Windows & Linux, License )
    - Fusion ( Type 2 - Mac OS-X , License)
    - vSphere/vCenter ( Type 1 - Bare Metal Hypervisor, License )
  - Linux KVM (Typer 2 - Opensource & Free )
 
  - Type 1 Hypervisor
    - they are meant to be used in Workstations & Servers
    - they are called Bare Metal Hypervisor
    - They don't need a Host OS
      
  - Type 2 Hypervisors
    - they are installed on Laptops/Desktops/Workstation with some OS
    - they depend on Host OS ( Windows, Mac, Linux )

## Processor and Packaging
- Processor has one or more CPU Cores
- Processor are packaged in 2 forms
  - SCM - Single Chip Module
    - only one Processor will be in the IC
  - MCM - Multiple chip Module
    - 2/4/8 Processors can be package in a single IC
- Examples
  - One Processors supports - 128/256/512 CPU Cores
  - MCM IC - let's take that it has 4 Processors in a single IC
  - Let's assume, each Processor supports 128 CPU Cores
  - Generally Server motherboards comes with multiple Processor Sockets ( 2/4/8 Socket Motherboards )
  - Final assumption
    - a server motherboard that supports 4 Sockets
    - each Socket is installed with MCM with 4 Processors on each IC
    - Processor - 128 CPU Cores
    - Total CPU Core - 4 Sockets x 4 x 128 = 2048 CPU Cores
    - Total logical cores - 2048 x 2 = 4096 virtual cores in a single server
  - Hypertheading
    - each Physical CPU double as 2/4/8 logical/virtual CPU Cores
  - each Operating Systems runs in a separate Virtual Machine
  - Virtual Machines are also referred as Guest OS
  - each Virtual Machine represents one Operating System
  - Each Virtual Machines requires ( hence called heavy-weight virtualization )
    - dedicated hardware resources
      - CPU
      - RAM
      - Storage

## Containerization
- application virtualization technology
- each container represents one application process
- container is not an Operating Sytem
- container has one application and its dependent libraries
- normally application processor will not get an IP address
- but containers get an IP Address
- container has their own file system ( files & folders )
- container has their own network stack with software defined network card
- light-weight virtualization
  - reason being, containers shares the hardwares on the underlying host operating systems
  - containers also shares the host-os Kernel
  - containers doesn't have their own kernel

## Virtualization vs Containerization
- Each Virtual Machine represents an OS while each Container represents a single application
- Each Virtual Machines gets dedicated hardware resources while containers running on the same OS shares the hardware resources on the host OS
- Each OS running on the Virtual Machine has its own Kernel, while containers don't have their own kernel, containers depends on Host OS kernel

## Container vs Normal Application Process
- Container is nothing but a regular application process but it runs in a separate namespace
- containers 
  - has its own network namespace
  - has its Port namespace ( Port range - 0 to 65535 )

## Linux Kernel Container Features
1. Namespace
   - helps in isolating one container from other containers running on the same OS
      
2. Control Group(CGroups)
   - helps in applying resource quota restrictions like
     - we can restrict a container on how many CPU Cores it can use at any point of time
     - we can restrict how much RAM a container use at the max
     - we can restrict, how much storage a container can use at the max

## What is a Container Runtime?
- it is low-level software that manages container images and containers
- it is not so user-friendly, hence end-user like us normally won't use Container Runtimes directly
- Examples
  - runC
  - CRI-O

## What is a Container Engine?
- it is high-level software
- it is very user-friendly
- internally it depends on Container Runtimes to manage container images and containers
- Examples
  - Docker is a Container Engine that depends on containerd which in turn depends on runC container runtime
  - Podman is a Container Engine that depends on CRI-O container runtime

## Docker Overview
- is a Container Engine
- follows client/server architecure
- the server component runs as a background service
- server component runs in root user context, hence all containers gain admin privilege
- is developed in Go language by Docker In organization
- comes in 2 flavours
  1. Docker Community Edition called Docker CE
  2. Docker Enterprise Edition called Docker EE (requires license)

## Docker - High Level Architecture
![Docker High Level Architecture](DockerHighLevelArchitecture.png)

## What is Container Orchestration Platform ?
- container though can be managed manually
  - creating a container
  - starting a container
  - stop/restart containers
  - kill/abort containers
  - delete container
- in real world no one manage container manually, hence we a software platform that can manage containerized application workloads
- which is called Container Orchestration Platform
- Examples
  - Docker Swarm
  - Google Kubernetes
  - Red Hat OpenShift
- the application that needs to be deployed into Container Orchestration Platforms has to be first of all containerized
- What are the benefits of using a Container Orchestration Platforms?
  - they offer in-built monitoring features to check the health of your application and repair it if found faulty 
  - they also monitoring features to check the readiness and liviness of your application, if required it repairs
  - provides an environment where you application can be made Highly available (HA)
  - When the user traffic to your containerized application increases, container orchestration platform can automatically scale it up i.e more instances of your application to handle heavy traffic
  - when the user traffic to your contianerized application decreases, container orchestration platform can automatically scale it down,.ie remove extra application instances which are idle
  - supports rolling update
    - is used to ugrage/downgrade your application from one version to other version without any down time
  - supports many different to expose your application via Service ( service discovery )
    - internal services 
    - external services
Examples
1. Docker Swarm
2. Google Kubernetes
3. Red Hat OpenShift

## Docker Swarm - Container Orchestration Platform
- this is Docker's native Container Orchestration Platform
- supports only Docker Containerized Application workloads
- it is easy to install and learn
- it is not production grade, hence normally no company uses this in production
- it is good for light-weight developer/qa setup

## Google kubernetes 
- aka K8s
- it is developed by Google in Go language
- it is opensource & free
- it supports many container runtimes/engines
- it is production grade
- Kubernetes does support a basic Dashboard(Web Interface) but it is not secure, hence administrators normally disable this to avoid any security issues
- it doesn't support Web Interface, supports only CLI
- supports extending Kubernetes API by adding new Custom Resource Definitions (CRD) to add your own Custom Resources (CR)s

## What is Kubernetes/OpenShift Operator
- it is a combition of Custom Resource & Custom Controller
- Kuberntes & Openshift support many different Controllers
- Controller are the one which supports monitoring
- Each Controller manages(monitors) one type of Resource

## Red Hat OpenShift Overview
- this Red Hat's distribution of Kubernetes
- Red Hat OpenShift is developed on top of Google Kubernetes
- Hence, whatever features are supported in Kubernetes are also supported in OpenShift
- OpenShift supports many additional features
- OpenShift supports CLI and Web Interface
- Openshift support User Mangagement which is not supported in Kubernetes
- OpenShift supports deploying application from source code, which is not supported in Kuberntes out of the box
- OpenShift comes with private Container Registry out of the box unline Kubernetes
- With the help of Custom Resource Definitions and CRs, OpenShift has added many additional features on top of Kubernetes
- this is a paid software
- comes with Red Hat support
- Openshift 4.x supports only CRI-O Container Runtime and Podman Container Engine
- AWS Managed OpenShift is called ROSA ( installing and managing openshift is taken care by AWS )
- Azure Managed openshift is called ARO ( installing and managing openshift is taken care by Azure )

## Red Hat OpenShift - High-Level Architecture
![OpenShift Architecture](openshift-architecture.png)
![OpenShift Architecture](openshift-architecture-2.png)

## Docker SWARM vs Kubernetes vs OpenShift

## What is a Pod?
- a collection of related containers
- a single application can be represented by one or more Pods
- one Pod is recommended to have one main application
- but it is okay to have supporting container(s) along the side of the main application
- user application runs inside Kubernetes/Openshift as Pod
- IP address is assigned on the Pod level, hence the containers that are part of the same Pod shares the IP address
- ports on the Pod are shared by all the containers running within the Pod

## Commonly used - Kubernetes/Openshift Resources
- Pod
- ReplicaSet
- Deployment
- DaemonSet
- Job
- CronJob
- StatefulSet
- Services
- EndPoint


