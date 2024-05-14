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
- supports inbuilt load balancing
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

## Lab - Checking the Openshift client version
```
oc version
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc version
Client Version: 4.14.12
Kustomize Version: v5.0.1
Server Version: 4.14.20
Kubernetes Version: v1.27.11+ec42b99  
</pre>

Kubernetes client version
```
kubectl version
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.4", GitCommit:"286cfa5f978c4a89c776347c82fa09a232eef144", GitTreeState:"clean", BuildDate:"2024-01-29T22:50:23Z", GoVersion:"go1.20.12 X:strictfipsruntime", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v5.0.1
Server Version: version.Info{Major:"1", Minor:"27", GitVersion:"v1.27.11+ec42b99", GitCommit:"9654661a61cc44110a8a3a801a82482ab63d063d", GitTreeState:"clean", BuildDate:"2024-04-04T12:53:37Z", GoVersion:"go1.20.12 X:strictfipsruntime", Compiler:"gc", Platform:"linux/amd64"}  
</pre>

## Lab - Listing the nodes in the Red Hat OpenShift cluster
```
oc get nodes
kubectl get nodes
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ <b>oc get nodes</b>
NAME                              STATUS   ROLES                         AGE   VERSION
master-1.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d
master-2.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d
master-3.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d
worker-1.ocp4.tektutor.org.labs   Ready    worker                        28d   v1.27.11+749fe1d
worker-2.ocp4.tektutor.org.labs   Ready    worker                        28d   v1.27.11+749fe1d
  
[jegan@tektutor.org openshift-may-2024]$ <b>kubectl get nodes</b>
NAME                              STATUS   ROLES                         AGE   VERSION
master-1.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d
master-2.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d
master-3.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d
worker-1.ocp4.tektutor.org.labs   Ready    worker                        28d   v1.27.11+749fe1d
worker-2.ocp4.tektutor.org.labs   Ready    worker                        28d   v1.27.11+749fe1d  
</pre>

## Lab - Finding more details about an OpenShift node
```
oc get nodes
oc describe node master-1.ocp4.tektutor.org.labs
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ <b>oc describe node master-1.ocp4.tektutor.org.labs</b>
Name:               master-1.ocp4.tektutor.org.labs
Roles:              control-plane,master,worker
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    disk=ssd
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=master-1.ocp4.tektutor.org.labs
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node-role.kubernetes.io/master=
                    node-role.kubernetes.io/worker=
                    node.openshift.io/os_id=rhcos
Annotations:        machineconfiguration.openshift.io/controlPlaneTopology: HighlyAvailable
                    machineconfiguration.openshift.io/currentConfig: rendered-master-01924f2b385b8dcf4e042dfc0e1726ab
                    machineconfiguration.openshift.io/desiredConfig: rendered-master-01924f2b385b8dcf4e042dfc0e1726ab
                    machineconfiguration.openshift.io/desiredDrain: uncordon-rendered-master-01924f2b385b8dcf4e042dfc0e1726ab
                    machineconfiguration.openshift.io/lastAppliedDrain: uncordon-rendered-master-01924f2b385b8dcf4e042dfc0e1726ab
                    machineconfiguration.openshift.io/lastSyncedControllerConfigResourceVersion: 3115076
                    machineconfiguration.openshift.io/reason: 
                    machineconfiguration.openshift.io/state: Done
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 16 Apr 2024 08:39:13 +0530
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  master-1.ocp4.tektutor.org.labs
  AcquireTime:     <unset>
  RenewTime:       Tue, 14 May 2024 14:04:56 +0530
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Tue, 14 May 2024 14:01:21 +0530   Tue, 16 Apr 2024 08:39:13 +0530   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Tue, 14 May 2024 14:01:21 +0530   Tue, 16 Apr 2024 08:39:13 +0530   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Tue, 14 May 2024 14:01:21 +0530   Tue, 16 Apr 2024 08:39:13 +0530   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Tue, 14 May 2024 14:01:21 +0530   Tue, 16 Apr 2024 08:44:30 +0530   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.168.122.20
  Hostname:    master-1.ocp4.tektutor.org.labs
Capacity:
  cpu:                8
  ephemeral-storage:  51837932Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             15991668Ki
  pods:               250
Allocatable:
  cpu:                7500m
  ephemeral-storage:  46700096229
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             14840692Ki
  pods:               250
System Info:
  Machine ID:                             6dfff066b0ce42fe99fc3ccb3fbf45e3
  System UUID:                            6dfff066-b0ce-42fe-99fc-3ccb3fbf45e3
  Boot ID:                                21730e20-82ea-44a0-b2ed-5d18aa4976fd
  Kernel Version:                         5.14.0-284.59.1.el9_2.x86_64
  OS Image:                               Red Hat Enterprise Linux CoreOS 414.92.202403270157-0 (Plow)
  Operating System:                       linux
  Architecture:                           amd64
  Container Runtime Version:              cri-o://1.27.4-6.1.rhaos4.14.gitd09e4c0.el9
  Kubelet Version:                        v1.27.11+749fe1d
  Kube-Proxy Version:                     v1.27.11+749fe1d
Non-terminated Pods:                      (45 in total)
  Namespace                               Name                                                              CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                               ----                                                              ------------  ----------  ---------------  -------------  ---
  knative-serving                         controller-678994f5d7-98g4h                                       110m (1%)     1 (13%)     120Mi (0%)       1000Mi (6%)    22d
  metallb-system                          speaker-tfppc                                                     20m (0%)      0 (0%)      40Mi (0%)        0 (0%)         3d11h
  openshift-apiserver                     apiserver-7dbf8d7788-6nb59                                        110m (1%)     0 (0%)      250Mi (1%)       0 (0%)         28d
  openshift-authentication                oauth-openshift-58dc999844-nq769                                  10m (0%)      0 (0%)      50Mi (0%)        0 (0%)         28d
  openshift-cluster-node-tuning-operator  tuned-6pvwx                                                       10m (0%)      0 (0%)      50Mi (0%)        0 (0%)         28d
  openshift-console-operator              console-operator-647c75b967-8qtvn                                 20m (0%)      0 (0%)      200Mi (1%)       0 (0%)         28d
  openshift-console                       console-7644f4994f-gm8qk                                          10m (0%)      0 (0%)      100Mi (0%)       0 (0%)         28d
  openshift-console                       downloads-86d9bcf76d-9tmjm                                        10m (0%)      0 (0%)      50Mi (0%)        0 (0%)         28d
  openshift-controller-manager            controller-manager-746fc45899-xx9m4                               100m (1%)     0 (0%)      100Mi (0%)       0 (0%)         3d11h
  openshift-dns                           dns-default-47l8t                                                 60m (0%)      0 (0%)      110Mi (0%)       0 (0%)         28d
  openshift-dns                           node-resolver-c6njj                                               5m (0%)       0 (0%)      21Mi (0%)        0 (0%)         28d
  openshift-etcd                          etcd-guard-master-1.ocp4.tektutor.org.labs                        10m (0%)      0 (0%)      5Mi (0%)         0 (0%)         28d
  openshift-etcd                          etcd-master-1.ocp4.tektutor.org.labs                              360m (4%)     0 (0%)      910Mi (6%)       0 (0%)         28d
  openshift-image-registry                image-registry-7d9d675f88-lc6p2                                   100m (1%)     0 (0%)      256Mi (1%)       0 (0%)         28d
  openshift-image-registry                node-ca-65qhq                                                     10m (0%)      0 (0%)      10Mi (0%)        0 (0%)         28d
  openshift-ingress-canary                ingress-canary-qxv5d                                              10m (0%)      0 (0%)      20Mi (0%)        0 (0%)         28d
  openshift-ingress                       router-default-6fbc577945-ll27k                                   100m (1%)     0 (0%)      256Mi (1%)       0 (0%)         21d
  openshift-kube-apiserver                kube-apiserver-guard-master-1.ocp4.tektutor.org.labs              10m (0%)      0 (0%)      5Mi (0%)         0 (0%)         28d
  openshift-kube-apiserver                kube-apiserver-master-1.ocp4.tektutor.org.labs                    290m (3%)     0 (0%)      1224Mi (8%)      0 (0%)         3d11h
  openshift-kube-controller-manager       kube-controller-manager-guard-master-1.ocp4.tektutor.org.labs     10m (0%)      0 (0%)      5Mi (0%)         0 (0%)         28d
  openshift-kube-controller-manager       kube-controller-manager-master-1.ocp4.tektutor.org.labs           80m (1%)      0 (0%)      500Mi (3%)       0 (0%)         28d
  openshift-kube-scheduler                openshift-kube-scheduler-guard-master-1.ocp4.tektutor.org.labs    10m (0%)      0 (0%)      5Mi (0%)         0 (0%)         28d
  openshift-kube-scheduler                openshift-kube-scheduler-master-1.ocp4.tektutor.org.labs          25m (0%)      0 (0%)      150Mi (1%)       0 (0%)         28d
  openshift-machine-config-operator       kube-rbac-proxy-crio-master-1.ocp4.tektutor.org.labs              20m (0%)      0 (0%)      50Mi (0%)        0 (0%)         28d
  openshift-machine-config-operator       machine-config-daemon-fbjr8                                       40m (0%)      0 (0%)      100Mi (0%)       0 (0%)         28d
  openshift-machine-config-operator       machine-config-server-6klv8                                       20m (0%)      0 (0%)      50Mi (0%)        0 (0%)         28d
  openshift-marketplace                   community-operators-46t78                                         10m (0%)      0 (0%)      50Mi (0%)        0 (0%)         3h33m
  openshift-monitoring                    alertmanager-main-0                                               9m (0%)       0 (0%)      120Mi (0%)       0 (0%)         28d
  openshift-monitoring                    monitoring-plugin-b889d6f95-2bjc5                                 10m (0%)      0 (0%)      50Mi (0%)        0 (0%)         28d
  openshift-monitoring                    node-exporter-khtjb                                               9m (0%)       0 (0%)      47Mi (0%)        0 (0%)         28d
  openshift-monitoring                    prometheus-adapter-d748bc674-t4vrr                                1m (0%)       0 (0%)      40Mi (0%)        0 (0%)         3d11h
  openshift-monitoring                    prometheus-k8s-1                                                  75m (1%)      0 (0%)      1104Mi (7%)      0 (0%)         28d
  openshift-monitoring                    prometheus-operator-admission-webhook-6c4c698b7d-n4p5w            5m (0%)       0 (0%)      30Mi (0%)        0 (0%)         28d
  openshift-monitoring                    thanos-querier-dc65b5668-stk8z                                    15m (0%)      0 (0%)      92Mi (0%)        0 (0%)         28d
  openshift-multus                        multus-additional-cni-plugins-tjjqm                               10m (0%)      0 (0%)      10Mi (0%)        0 (0%)         28d
  openshift-multus                        multus-admission-controller-68dfc47cb4-9sqms                      20m (0%)      0 (0%)      70Mi (0%)        0 (0%)         14d
  openshift-multus                        multus-mts72                                                      10m (0%)      0 (0%)      65Mi (0%)        0 (0%)         28d
  openshift-multus                        network-metrics-daemon-dknss                                      20m (0%)      0 (0%)      120Mi (0%)       0 (0%)         28d
  openshift-network-diagnostics           network-check-source-8c95bf67d-hckd2                              10m (0%)      0 (0%)      40Mi (0%)        0 (0%)         28d
  openshift-network-diagnostics           network-check-target-k9b77                                        10m (0%)      0 (0%)      15Mi (0%)        0 (0%)         28d
  openshift-network-node-identity         network-node-identity-s9g8r                                       20m (0%)      0 (0%)      100Mi (0%)       0 (0%)         28d
  openshift-oauth-apiserver               apiserver-5dbd945565-flzlb                                        150m (2%)     0 (0%)      200Mi (1%)       0 (0%)         28d
  openshift-route-controller-manager      route-controller-manager-7df59564f-hskwq                          100m (1%)     0 (0%)      100Mi (0%)       0 (0%)         3d11h
  openshift-sdn                           sdn-controller-rblqn                                              20m (0%)      0 (0%)      70Mi (0%)        0 (0%)         28d
  openshift-sdn                           sdn-hblrp                                                         110m (1%)     0 (0%)      220Mi (1%)       0 (0%)         28d
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests      Limits
  --------           --------      ------
  cpu                2174m (28%)   1 (13%)
  memory             7180Mi (49%)  1000Mi (6%)
  ephemeral-storage  0 (0%)        0 (0%)
  hugepages-1Gi      0 (0%)        0 (0%)
  hugepages-2Mi      0 (0%)        0 (0%)
Events:              <none>  
</pre>

## Lab - Finding IP address, Node OS and Container Runtime details
```
oc get nodes -o wide
```

Expected output
<pre>
[jegan@tektutor.org <b>openshift-may-2024]$ oc get nodes -o wide</b>
NAME                              STATUS   ROLES                         AGE   VERSION            INTERNAL-IP       EXTERNAL-IP   OS-IMAGE                                                       KERNEL-VERSION                 CONTAINER-RUNTIME
master-1.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d   192.168.122.20    <none>        Red Hat Enterprise Linux CoreOS 414.92.202403270157-0 (Plow)   5.14.0-284.59.1.el9_2.x86_64   cri-o://1.27.4-6.1.rhaos4.14.gitd09e4c0.el9
master-2.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d   192.168.122.211   <none>        Red Hat Enterprise Linux CoreOS 414.92.202403270157-0 (Plow)   5.14.0-284.59.1.el9_2.x86_64   cri-o://1.27.4-6.1.rhaos4.14.gitd09e4c0.el9
master-3.ocp4.tektutor.org.labs   Ready    control-plane,master,worker   28d   v1.27.11+749fe1d   192.168.122.194   <none>        Red Hat Enterprise Linux CoreOS 414.92.202403270157-0 (Plow)   5.14.0-284.59.1.el9_2.x86_64   cri-o://1.27.4-6.1.rhaos4.14.gitd09e4c0.el9
worker-1.ocp4.tektutor.org.labs   Ready    worker                        28d   v1.27.11+749fe1d   192.168.122.228   <none>        Red Hat Enterprise Linux CoreOS 414.92.202403270157-0 (Plow)   5.14.0-284.59.1.el9_2.x86_64   cri-o://1.27.4-6.1.rhaos4.14.gitd09e4c0.el9
worker-2.ocp4.tektutor.org.labs   Ready    worker                        28d   v1.27.11+749fe1d   192.168.122.56    <none>        Red Hat Enterprise Linux CoreOS 414.92.202403270157-0 (Plow)   5.14.0-284.59.1.el9_2.x86_64   cri-o://1.27.4-6.1.rhaos4.14.gitd09e4c0.el9
</pre>

## Lab - Editing a node details ( don't really edit anything )
```
oc edit node master-1.ocp4.tektutor.org.labs
```

## Lab - Listing all pods(applications) on all nodes and namespaces
```
oc get pods --all-namespaces
```

## Lab - List the API Server ( one of the control plane component that runs in each master node )

In the below command, -n represents namespaces/project.

```
oc get pods -n openshift-apiserver
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get pods -n openshift-apiserver
NAME                         READY   STATUS    RESTARTS   AGE
apiserver-7dbf8d7788-6nb59   2/2     Running   24         28d
apiserver-7dbf8d7788-9zkmb   2/2     Running   24         28d
apiserver-7dbf8d7788-lndws   2/2     Running   24         28d  
</pre>

In order to find the below pod IP address and the node each Pod is running, you could try the below command
```
oc get pods -n openshift-apiserver -o wide
```

Expected output
<pre>
jegan@tektutor.org openshift-may-2024]$ <b>oc get pods -n openshift-apiserver -o wide</b>
NAME                         READY   STATUS    RESTARTS   AGE   IP            NODE                              NOMINATED NODE   READINESS GATES
apiserver-7dbf8d7788-6nb59   2/2     Running   24         28d   10.128.0.8    master-1.ocp4.tektutor.org.labs   <none>           <none>
apiserver-7dbf8d7788-9zkmb   2/2     Running   24         28d   10.129.0.45   master-2.ocp4.tektutor.org.labs   <none>           <none>
apiserver-7dbf8d7788-lndws   2/2     Running   24         28d   10.130.0.48   master-3.ocp4.tektutor.org.labs   <none>          <none></pre>

## Lab - List all the projects/namespaces in Openshift
In Openshift, applications are deployed in a separate project.  Each team, will create their own project to deplooy their applications.

```
oc get projects
oc get namespaces
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get projects
NAME                                               DISPLAY NAME   STATUS
aap                                                               Active
default                                                           Active
jegan                                                             Active
jegan-new                                                         Active
knative-eventing                                                  Active
knative-serving                                                   Active
knative-serving-ingress                                           Active
kube-node-lease                                                   Active
kube-public                                                       Active
kube-system                                                       Active
metallb-system                                                    Active
openshift                                                         Active
openshift-apiserver                                               Active
openshift-apiserver-operator                                      Active
openshift-authentication                                          Active
openshift-authentication-operator                                 Active
openshift-cloud-controller-manager                                Active
openshift-cloud-controller-manager-operator                       Active
openshift-cloud-credential-operator                               Active
openshift-cloud-network-config-controller                         Active
openshift-cluster-csi-drivers                                     Active
openshift-cluster-machine-approver                                Active
openshift-cluster-node-tuning-operator                            Active
openshift-cluster-samples-operator                                Active
openshift-cluster-storage-operator                                Active
openshift-cluster-version                                         Active
openshift-config                                                  Active
openshift-config-managed                                          Active
openshift-config-operator                                         Active
openshift-console                                                 Active
openshift-console-operator                                        Active
openshift-console-user-settings                                   Active
openshift-controller-manager                                      Active
openshift-controller-manager-operator                             Active
openshift-dns                                                     Active
openshift-dns-operator                                            Active
openshift-etcd                                                    Active
openshift-etcd-operator                                           Active
openshift-host-network                                            Active
openshift-image-registry                                          Active
openshift-infra                                                   Active
openshift-ingress                                                 Active
openshift-ingress-canary                                          Active
openshift-ingress-operator                                        Active
openshift-insights                                                Active
openshift-kni-infra                                               Active
openshift-kube-apiserver                                          Active
openshift-kube-apiserver-operator                                 Active
openshift-kube-controller-manager                                 Active
openshift-kube-controller-manager-operator                        Active
openshift-kube-scheduler                                          Active
openshift-kube-scheduler-operator                                 Active
openshift-kube-storage-version-migrator                           Active
openshift-kube-storage-version-migrator-operator                  Active
openshift-machine-api                                             Active
openshift-machine-config-operator                                 Active
openshift-marketplace                                             Active
openshift-monitoring                                              Active
openshift-multus                                                  Active
openshift-network-diagnostics                                     Active
openshift-network-node-identity                                   Active
openshift-network-operator                                        Active
openshift-node                                                    Active
openshift-nutanix-infra                                           Active
openshift-oauth-apiserver                                         Active
openshift-openstack-infra                                         Active
openshift-operator-lifecycle-manager                              Active
openshift-operators                                               Active
openshift-ovirt-infra                                             Active
openshift-route-controller-manager                                Active
openshift-sdn                                                     Active
openshift-serverless                                              Active
openshift-service-ca                                              Active
openshift-service-ca-operator                                     Active
openshift-user-workload-monitoring                                Active
openshift-vsphere-infra                                           Active
  
[jegan@tektutor.org openshift-may-2024]$ oc get namespaces
NAME                                               STATUS   AGE
aap                                                Active   25d
default                                            Active   28d
jegan                                              Active   21d
jegan-new                                          Active   21d
knative-eventing                                   Active   22d
knative-serving                                    Active   22d
knative-serving-ingress                            Active   22d
kube-node-lease                                    Active   28d
kube-public                                        Active   28d
kube-system                                        Active   28d
metallb-system                                     Active   28d
openshift                                          Active   28d
openshift-apiserver                                Active   28d
openshift-apiserver-operator                       Active   28d
openshift-authentication                           Active   28d
openshift-authentication-operator                  Active   28d
openshift-cloud-controller-manager                 Active   28d
openshift-cloud-controller-manager-operator        Active   28d
openshift-cloud-credential-operator                Active   28d
openshift-cloud-network-config-controller          Active   28d
openshift-cluster-csi-drivers                      Active   28d
openshift-cluster-machine-approver                 Active   28d
openshift-cluster-node-tuning-operator             Active   28d
openshift-cluster-samples-operator                 Active   28d
openshift-cluster-storage-operator                 Active   28d
openshift-cluster-version                          Active   28d
openshift-config                                   Active   28d
openshift-config-managed                           Active   28d
openshift-config-operator                          Active   28d
openshift-console                                  Active   28d
openshift-console-operator                         Active   28d
openshift-console-user-settings                    Active   28d
openshift-controller-manager                       Active   28d
openshift-controller-manager-operator              Active   28d
openshift-dns                                      Active   28d
openshift-dns-operator                             Active   28d
openshift-etcd                                     Active   28d
openshift-etcd-operator                            Active   28d
openshift-host-network                             Active   28d
openshift-image-registry                           Active   28d
openshift-infra                                    Active   28d
openshift-ingress                                  Active   28d
openshift-ingress-canary                           Active   28d
openshift-ingress-operator                         Active   28d
openshift-insights                                 Active   28d
openshift-kni-infra                                Active   28d
openshift-kube-apiserver                           Active   28d
openshift-kube-apiserver-operator                  Active   28d
openshift-kube-controller-manager                  Active   28d
openshift-kube-controller-manager-operator         Active   28d
openshift-kube-scheduler                           Active   28d
openshift-kube-scheduler-operator                  Active   28d
openshift-kube-storage-version-migrator            Active   28d
openshift-kube-storage-version-migrator-operator   Active   28d
openshift-machine-api                              Active   28d
openshift-machine-config-operator                  Active   28d
openshift-marketplace                              Active   28d
openshift-monitoring                               Active   28d
openshift-multus                                   Active   28d
openshift-network-diagnostics                      Active   28d
openshift-network-node-identity                    Active   28d
openshift-network-operator                         Active   28d
openshift-node                                     Active   28d
openshift-nutanix-infra                            Active   28d
openshift-oauth-apiserver                          Active   28d
openshift-openstack-infra                          Active   28d
openshift-operator-lifecycle-manager               Active   28d
openshift-operators                                Active   28d
openshift-ovirt-infra                              Active   28d
openshift-route-controller-manager                 Active   28d
openshift-sdn                                      Active   28d
openshift-serverless                               Active   22d
openshift-service-ca                               Active   28d
openshift-service-ca-operator                      Active   28d
openshift-user-workload-monitoring                 Active   28d
openshift-vsphere-infra                            Active   28d  
</pre>

## Lab - Creating a new project
I would recommend each one of you creating a project in your name.  Normally this is not recommended best practice at work place, but in our training to avoid conflicts please use your name. Replace 'jegan' with your name.

```
oc new-project jegan
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc new-project jegan
Now using project "jegan" on server "https://api.ocp4.tektutor.org.labs:6443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.43 -- /agnhost serve-hostname  
</pre>

## Lab - Switching between projects
```
oc project default
oc project jegan
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ <b>oc project default</b>
Now using project "default" on server "https://api.ocp4.tektutor.org.labs:6443".
  
[jegan@tektutor.org openshift-may-2024]$ <b>oc project jegan</b>
Now using project "jegan" on server "https://api.ocp4.tektutor.org.labs:6443".  
</pre>

## Lab - Finding the current active project
```
oc project
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ <b>oc project</b>
Using project "jegan" on server "https://api.ocp4.tektutor.org.labs:6443".  
</pre>

## Lab - Deploying your first application into Red Hat OpenShift
In the below command, replace 'jegan' with your project name. The below command will download the nginx:latest docker image from Docker Hub Website ( Remote Registry )
```
oc project jegan
oc create deployment nginx --image=nginx:latest
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ <b>oc project jegan</b>
Now using project "jegan" on server "https://api.ocp4.tektutor.org.labs:6443".
  
[jegan@tektutor.org openshift-may-2024]$ <b>oc create deployment nginx --image=nginx:latest</b>
deployment.apps/nginx created  
</pre>

## Lab - Listing the application deployments
Most resources in Kubernetes/Openshift supports Plural form, Singular form and Short name.
```
oc get deployments
oc get deployment
oc get deploy
```
Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get deployments
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   0/1     1            0           102s
[jegan@tektutor.org openshift-may-2024]$ oc get deployment
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   0/1     1            0           105s
[jegan@tektutor.org openshift-may-2024]$ oc get deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   0/1     1            0           108s  
</pre>  


## Lab - Listing the replicasets
```
oc get replicasets
oc get replicaset
oc get rs
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get replicasets
NAME               DESIRED   CURRENT   READY   AGE
nginx-7bf8c77b5b   1         1         0       4m11s
[jegan@tektutor.org openshift-may-2024]$ oc get replicaset
NAME               DESIRED   CURRENT   READY   AGE
nginx-7bf8c77b5b   1         1         0       4m14s
[jegan@tektutor.org openshift-may-2024]$ oc get rs
NAME               DESIRED   CURRENT   READY   AGE
nginx-7bf8c77b5b   1         1         0       4m16s  
</pre>

## Listing the pods in your project
```
oc get pods
oc get pod
oc get po
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get pods
NAME                     READY   STATUS             RESTARTS        AGE
nginx-7bf8c77b5b-r6q2j   0/1     CrashLoopBackOff   5 (2m38s ago)   6m6s
[jegan@tektutor.org openshift-may-2024]$ oc get pod
NAME                     READY   STATUS             RESTARTS        AGE
nginx-7bf8c77b5b-r6q2j   0/1     CrashLoopBackOff   5 (2m41s ago)   6m9s
[jegan@tektutor.org openshift-may-2024]$ oc get po
NAME                     READY   STATUS             RESTARTS        AGE
nginx-7bf8c77b5b-r6q2j   0/1     CrashLoopBackOff   5 (2m42s ago)   6m10s  
</pre>

## Lab - Troubleshooting - debugging and understanding why the Pod is crashing
You need to replace the below pod with your nginx pod name
```
oc logs -f nginx-7bf8c77b5b-r6q2j
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc logs -f nginx-7bf8c77b5b-r6q2j
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: can not modify /etc/nginx/conf.d/default.conf (read-only file system?)
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2024/05/14 09:08:42 [warn] 1#1: the "user" directive makes sense only if the master process runs with super-user privileges, ignored in /etc/nginx/nginx.conf:2
nginx: [warn] the "user" directive makes sense only if the master process runs with super-user privileges, ignored in /etc/nginx/nginx.conf:2
2024/05/14 09:08:42 [emerg] 1#1: mkdir() "/var/cache/nginx/client_temp" failed (13: Permission denied)
nginx: [emerg] mkdir() "/var/cache/nginx/client_temp" failed (13: Permission denied)  
</pre>

In our Openshift cluster, in all the nodes we have installed Red Hat Enterprise Core OS (RHCOS). The Red Hat Enterprise Core OS enforces many best practices.  

Some of the best practices it enforces is, 
- user application ie nginx in this case are not supposed to be running in root user context.
- RHCOS also maintains certains folders as read-only
- In this case /var folder is write protected for normal user applications, hence RHCOS is denying permission to create folder under the /var directory.
- it reservers ports below 1024 for internal use, hence user-applications are not supposed to be using ports below 1024.

## Lab - Deleting an application deployment
```
oc get deployments
oc delete deploy/nginx
oc get deploy,rs,po
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get deployments
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   0/1     1            0           18m
  
[jegan@tektutor.org openshift-may-2024]$ oc delete deploy/nginx
deployment.apps "nginx" deleted
  
[jegan@tektutor.org openshift-may-2024]$ oc get deploy,rs,po
No resources found in jegan namespace.  
</pre>

## Lab - Deploying nginx web server with bitnami nginx image from Docker Hub Remote Registry
```
oc project
oc get all
oc create deploy nginx --image=bitnami/nginx:latest
oc get deploy,rs,po
oc get po -w
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc project
Using project "jegan" on server "https://api.ocp4.tektutor.org.labs:6443".
  
[jegan@tektutor.org openshift-may-2024]$ oc get all
Warning: apps.openshift.io/v1 DeploymentConfig is deprecated in v4.14+, unavailable in v4.10000+
No resources found in jegan namespace
  
[jegan@tektutor.org openshift-may-2024]$ oc create deploy nginx --image=bitnami/nginx:latest
deployment.apps/nginx create
  
[jegan@tektutor.org openshift-may-2024]$ oc get deploy,rs,po
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   0/1     1            0           4s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-bb865dc5f   1         1         0       4s

NAME                        READY   STATUS              RESTARTS   AGE
pod/nginx-bb865dc5f-45szb   0/1     ContainerCreating   0          4
  
[jegan@tektutor.org openshift-may-2024]$ oc get po -w
NAME                    READY   STATUS              RESTARTS   AGE
nginx-bb865dc5f-45szb   0/1     ContainerCreating   0          12s
nginx-bb865dc5f-45szb   1/1     Running             0          13s 
</pre>

## Lab - Finding IP address of a Pod and in which node is runing
```
oc get po -o wide
```

Expectd output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc get po -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP             NODE                              NOMINATED NODE   READINESS GATES
nginx-bb865dc5f-45szb   1/1     Running   0          7m58s   10.128.2.238   worker-1.ocp4.tektutor.org.labs   <none>           <none>  
</pre>

## Lab - Editing a Pod
```
oc get pods
oc edit pod nginx-bb865dc5f-45szb
```

Expected output
<pre>
[jegan@tektutor.org openshift-may-2024]$ oc edit pod nginx-bb865dc5f-45szb
pod/nginx-bb865dc5f-45szb edited  
</pre>
