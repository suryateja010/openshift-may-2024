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

## Lab - Creating a Pod using docker ( Just for our understanding )
```
docker run -d --name nginx_pause --hostname nginx nginx gcr.io/google_containers/pause:latest
docker run -d --name nginx --network=container:nginx_pause bitnami/nginx:latest
docker ps
```

Let's find the IP Address of the nginx_pause container
```
docker inspect -f {{.NetworkSettings.IPAddress}} nginx_pause
docker exec -it nginx sh
hostname -i
exit
```

Expected output
<pre>
[root@tektutor.org ~]# docker run -d --name nginx_pause --hostname nginx gcr.io/google_containers/pause:latest
58cae658dba0f2d80671e527181e5ccc3a3c8c0a24230be1bc31d6d0cf98bc15
[root@tektutor.org ~]# docker ps
CONTAINER ID   IMAGE                                   COMMAND    CREATED         STATUS         PORTS     NAMES
58cae658dba0   gcr.io/google_containers/pause:latest   "/pause"   3 seconds ago   Up 2 seconds             nginx_pause
[root@tektutor.org ~]# docker run -d --name nginx --network=container:nginx_pause bitnami/nginx:latest
Unable to find image 'bitnami/nginx:latest' locally
latest: Pulling from bitnami/nginx
2f2e827ef32f: Pull complete 
Digest: sha256:476d94e773ee511bb789fafa69b2fcf39a91549dbe1386b1f64fb8f876ac3883
Status: Downloaded newer image for bitnami/nginx:latest
b44c9f65be28a22b9049b8ce66e83881d78bfb643c3ccb2bfb503a0a379ebd46
[root@tektutor.org ~]# docker ps
CONTAINER ID   IMAGE                                   COMMAND                  CREATED              STATUS              PORTS     NAMES
b44c9f65be28   bitnami/nginx:latest                    "/opt/bitnami/script…"   3 seconds ago        Up 2 seconds                  nginx
58cae658dba0   gcr.io/google_containers/pause:latest   "/pause"                 About a minute ago   Up About a minute             nginx_pause
[root@tektutor.org ~]# docker inspect nginx_pause | grep IPA
            "SecondaryIPAddresses": null,
            "IPAddress": "172.17.0.2",
                    "IPAMConfig": null,
                    "IPAddress": "172.17.0.2",
[root@tektutor.org ~]# docker exec -it nginx sh
$ hostname
nginx
$ hostname -i
172.17.0.2
$ exit  
</pre>
