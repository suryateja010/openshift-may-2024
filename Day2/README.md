# Day 2

## Lab - Bash completion for oc commands (requires root privilege - hence I have already installed it for you)
In case of CentOS 7.x
```
oc completion bash > /etc/profile.d/
docker completion bash > /etc/profile.d/docker
exit
```

In case of RHEL
```
oc completion bash > /etc/bash_completion.d/
docker completion bash > /etc/bash_completion.d/docker
exit
```

How to check oc bash completion works in terminal?
- Try oc [space] [Tab] key
- Try docker [space] [Tab] key

## Info - What happens when we create a deployment into openshift

The below command, oc is the client tool
```
oc create deployment --image=bitnami/nginx:latest --replicas=3
```

<pre>
- the oc client tool will make a REST call to API server requesting it to create a deployment with name nginx using image bitnami/nginx:latest with 3 Pod instances
- the API Server receives the REST call from oc and then it creates a deployment record named nginx
- the API Server sends a broadcasting event that a new deployment is created
- the deployment controller receives the event from API Server, it then sends a REST call to API Server requesting it to create a ReplicaSet with 3 Desired Pod using image bitnami/nginx:latest
- the API Server receives the REST call from Deployment Controller and then it creates a ReplicaSet record in the etcd database
- the API Server sends a broadcasting event that a new ReplicaSet is created
- the ReplicaSet Controller receives the event from API Server, it then sends REST calls to API Server requesting it to create 3 Pods
- The API Server receives the REST call from ReplicaSet Controller and then it creates 3 Pod records in the etcd database
- the API sends broadcasting events that 3 new Pods are created
- the Scheduler receives the event from API server, it then identifies nodes where those 3 Pods can be deployed.  
- the Scheduler makes a REST call to API Server with the Pod scheduling recommendations
- the API Server receives the REST call from Scheduler, it then retrieves the Pod entry from etcd database and updates the scheduling details on the etcd database for the respective Pods
- the API Server will send broadcasting events that Pod sheduled to so and so nodes
- the kubelet container agent running on the respective node receives the event from API Server
- the kubelet pulls(downloads) the container image if it is not there already, it then creates the container and start the container on the local node where the kubelet is running
- the kubelet make a REST call to API Server sharing the status of the containers, this happens in heart-beat like periodic fashion
- the API Server retrieves the Pod record from the etcd database and update the Pod status based on the status update it received from kubelet
</pre>
