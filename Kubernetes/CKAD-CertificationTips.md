# Kubernetes Imperative Commands

In Kubernetes, while you would primarily work using declarative approaches with definition files, imperative commands can be incredibly useful for quick, one-time tasks or for generating definition templates. These commands can save time, especially during exams or time-sensitive operations.

## Helpful Options

Before using the commands below, familiarize yourself with the following options that can streamline your workflow:

- `--dry-run=client`: Tests your command without actually creating the resource. It checks if the resource **can** be created and validates the command.
- `-o yaml`: Outputs the resource definition in YAML format. This allows you to generate resource definition files quickly.

You can use these options together with output redirection to generate YAML files that can be modified and used later.

For example:
```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx-pod.yaml
```

## POD Commands

### Create an NGINX Pod

```bash
kubectl run nginx --image=nginx
```

### Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)

```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

## Deployment Commands

### Create a Deployment

```bash
kubectl create deployment --image=nginx nginx
```

### Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)

```bash
kubectl create deployment --image=nginx nginx --dry-run -o yaml
```

### Generate Deployment with 4 Replicas

```bash
kubectl create deployment nginx --image=nginx --replicas=4
```

You can also scale deployment using the kubectl scale command.

```bash
kubectl scale deployment nginx --replicas=4
```

### Another way to do this is to save the YAML definition to a file and modify

```bash
kubectl create deployment nginx --image=nginx--dry-run=client -o yaml > nginx-deployment.yaml
```

You can then update the YAML file with the replicas or any other field before creating the deployment.


# Service

### Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379

```bash
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
```

(This will automatically use the pod's labels as selectors)

Or

```bash
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
```

(This will not use the pods' labels as selectors; instead it will assume selectors as app=redis. You cannot pass in selectors as an option. So it does not work well if your pod has a different label set. So generate the file and modify the selectors before creating the service)



### Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes:

```bash
kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml
```

(This will automatically use the pod's labels as selectors, but you cannot specify the node port. You have to generate a definition file and then add the node port in manually before creating the service with the pod.)

Or

```bash
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml
```

(This will not use the pods' labels as selectors)

Both the above commands have their own challenges. 
While one of it cannot accept a selector the other cannot accept a node port. 
It is recommended going with the `kubectl expose` command. If you need to specify a node port, generate a definition file using the same command and manually input the nodeport before creating the service.


### Reference:
https://kubernetes.io/docs/reference/kubectl/conventions/


### Sample Questions:

1. Deploy a pod named nginx-pod using the nginx:alpine image.

```bash
kubectl run nginx-pod --image=nginx:alpine
```

2. Deploy a redis pod using the redis:alpine image with the labels set to tier=db.
Either use imperative commands to create the pod with the labels. Or else use imperative commands to generate the pod definition file, 
then add the labels before creating the pod using the file.

```bash
kubectl run redis --image=redis:alpine --dry-run=client -o yaml > redis-pod.yaml
```

- Add the labels to the metadata section in the file.

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: redis
    tier: db
  name: redis
spec:
  containers:
    - image: redis:alpine
      name: redis
      resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

Create the pod using the file.

```bash
kubectl create -f redis-pod.yaml
```

3. Create a service redis-service to expose the redis application within the cluster on port 6379.
Use imperative commands.

```bash
kubectl expose pod redis --port=6379 --name redis-service
```

4. Create a deployment named webapp using the image kodekloud/webapp-color with 3 replicas.
Try to use imperative commands only. Do not create definition files.

```bash
kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3
```

5. Create a new pod named custom-nginx using the nginx image, and run it on container port 8080. 

```bash
kubectl run custom-nginx --image=nginx --port=8080
```

6. Create a new namespace called dev-ns.
Use imperative commands.

```bash
kubectl create namespace dev-ns
```

7. Create a new deployment called redis-deploy in the dev-ns namespace with the redis image. It should have 2 replicas.

```bash
kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns
```

8. Create a pod called httpd using the image httpd:alpine in the default namespace. 
Next, create a service of type ClusterIP by the same name (httpd). The target port for the service should be 80. 
Try to do this with as few steps as possible using imperative kubectl command

```bash
kubectl run httpd --image=httpd:alpine --port=80 --expose
```




