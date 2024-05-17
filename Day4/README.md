# Day 4

## Installing Helm package manager in Linux
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## Helm Overview
- a package manager for Kubernetes and Openshift orchestration platforms
- using helm we can package our application as Charts
- our end-users will be able to use the charts we packaged to install into openshift
- helm tool is aware of Kubernetes and Openshift

## Lab - Creating a custom helm package for wordpress and mariadb multi-pod application
```
cd ~/openshift-may-2024
git pull
cd Day4/helm
helm create wordpress-chart
rm -rf wordpress-char/templates/*
#cp yaml-files/* wordpress-chart/templates
ls -l
helm package wordpress-chart
helm install wordpress wordpress-chart-0.1.0.tgz

helm list
```

You may verify if the wordpress and mysql is deployed properly.

## Lab - Deploying redis database with persistent volume
```
oc new-app --name=redis -e REDIS_PASSWORD=pass@123 bitnami/redis:latest --dry-run -o yaml
oc new-app --name=redis -e REDIS_PASSWORD=pass@123 bitnami/redis:latest --dry-run -o yaml > deploy-redis.yml

```

Expected output
<pre>
[jegan@tektutor.org redis]$ oc new-app --name=redis -e REDIS_PASSWORD=pass@123 bitnami/redis:latest --dry-run -o yaml
apiVersion: v1
items:
- apiVersion: image.openshift.io/v1
  kind: ImageStream
  metadata:
    annotations:
      openshift.io/generated-by: OpenShiftNewApp
    creationTimestamp: null
    labels:
      app: redis
      app.kubernetes.io/component: redis
      app.kubernetes.io/instance: redis
    name: redis
  spec:
    lookupPolicy:
      local: false
    tags:
    - annotations:
        openshift.io/imported-from: bitnami/redis:latest
      from:
        kind: DockerImage
        name: bitnami/redis:latest
      generation: null
      importPolicy:
        importMode: Legacy
      name: latest
      referencePolicy:
        type: ""
  status:
    dockerImageRepository: ""
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    annotations:
      image.openshift.io/triggers: '[{"from":{"kind":"ImageStreamTag","name":"redis:latest"},"fieldPath":"spec.template.spec.containers[?(@.name==\"redis\")].image"}]'
      openshift.io/generated-by: OpenShiftNewApp
    creationTimestamp: null
    labels:
      app: redis
      app.kubernetes.io/component: redis
      app.kubernetes.io/instance: redis
    name: redis
  spec:
    replicas: 1
    selector:
      matchLabels:
        deployment: redis
    strategy: {}
    template:
      metadata:
        annotations:
          openshift.io/generated-by: OpenShiftNewApp
        creationTimestamp: null
        labels:
          deployment: redis
      spec:
        containers:
        - env:
          - name: REDIS_PASSWORD
            value: pass@123
          image: ' '
          name: redis
          ports:
          - containerPort: 6379
            protocol: TCP
          resources: {}
  status: {}
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      openshift.io/generated-by: OpenShiftNewApp
    creationTimestamp: null
    labels:
      app: redis
      app.kubernetes.io/component: redis
      app.kubernetes.io/instance: redis
    name: redis
  spec:
    ports:
    - name: 6379-tcp
      port: 6379
      protocol: TCP
      targetPort: 6379
    selector:
      deployment: redis
  status:
    loadBalancer: {}
kind: List
metadata: {}  
</pre>
