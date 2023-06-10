# Infracubator Assignments (Kubernetes)

## Assignment-1

1. Create a Pod specification for the metadataservice
     a. image : luckyganesh/metadata-service:v1 (for M1 chip - luckyganesh/metadata-service:v1-arm)
     b. Port to be exposed 8080
2. Check the logs
3. Check the Pod IP
4. Hit the POD ip with /metadata url path from either inside minikube ( minikube ssh ) or colima ( colima ssh ) based on whatever you are using
5. Describe the POD
6. Exec into the container using `/bin/sh` command.

<img width="1347" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/51344573-f188-49e5-9469-e43b568efcc9">

<img width="1351" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/4f4d9c1b-4547-4b79-8ca2-0349866de27e">

<img width="1347" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/a61af78e-ad4c-4d1c-94a9-b35538e20954">

<img width="1348" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/72136259-07e6-421f-a3b4-a481925a05da">

<img width="1352" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/99248843-890b-4716-8e97-9d62ec8e12ee">

<img width="1348" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/4b6a5aae-accb-4119-8f19-a1ed9e1b5ddb">

## Assignment-2

<img width="798" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/70de328d-7d55-48b0-b1bd-7278d3671cfc">

```
metadata_replicaset.yaml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: metadata-service
  labels:
    tier: metadata-service
spec:
  replicas: 2
  selector:
    matchLabels:
      tier: metadata-service
  template:
    metadata:
      labels:
        tier: metadata-service
    spec:
      containers:
        - name: metadata-replicaset
          image: luckyganesh/metadata-service:v1
          ports:
            - containerPort: 8080
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 20
            timeoutSeconds: 10
          readinessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 20
            timeoutSeconds: 10
```

```
kubectl create -f metadata_replicaset.yaml
```

```
kubectl get replicasets
```

```
kubectl get pods
```

```
curl --header "Content-Type: application/json" \
--request POST \
--data '{"group":"krishchak","name":"city","value":"Kolkata"}' \
"http://172.17.0.9:8080/metadata"
```

```
curl http://172.17.0.9:8080/metadata
```

## Assignment-3

<img width="785" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/32d13f0d-f501-4a4c-a751-293e98880f9a">

Note:
1. In case of minikube, node-ip will be minikube ip.
2. In case of colima, node-ip will be localhost itself.

<img width="726" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/dd085fc0-23de-404f-b9a8-8e0879c2686a">

<img width="792" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/b4cd3664-141f-484e-b978-b175d61888a3">

```
metadata_svc_nodeport.yaml

apiVersion: v1
kind: Service
metadata:
  name: metadata-service
spec:
  type: NodePort
  ports:
    - name: http
      port: 8080
      targetPort: 8080
      nodePort: 30000
  selector:
    tier: metadata-service
```

```
kubectl get svc
```

```
kubectl describe service metadata-service
```

```
kubectl expose po metadata --port=80 --target-port=8080 --type=NodePort --dry-run=client -o yaml > metadata_svc_nodeport
```

```
curl http://192.168.59.102:32175/actuator/health
```

## Assignment-4

<img width="789" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/b7a78b17-cdf6-47d7-8ca8-e217fd332079">

Image to use for metadata service
- For Intel Mac - luckyganesh/metadata-service:v2
- For M1 Mac - luckyganesh/metadata-service:v2-arm

Please check the right image to use mongodb in the dockerhub.

```
kubectl create -f mongo-pod-definition.yaml
```

```
mongo-pod-definition.yaml

apiVersion: v1
kind: Pod
metadata:
 name: mongo-pod
 labels:
   db: mongodb
spec:
 containers:
 - name: mongo-container
   image: mongo
   ports:
   - containerPort: 8080
```

```
kubectl create -f mongodb-cluster-ip.yaml
```

```
mongodb-cluster-ip.yaml

apiVersion: v1
kind: Service
metadata:
 name: mongo
 labels:
  db: mongodb
spec:
 type: ClusterIP
 ports:
 - port: 27017
   targetPort: 27017
 selector:
  db: mongodb
```

```
kubectl create -f metadata_replicaset.yaml
```

```
metadata_replicaset.yaml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
 name: metadata-service
 labels:
  tier: metadata-service
spec:
 replicas: 2
 selector:
  matchLabels:
   tier: metadata-service
 template:
  metadata:
   labels:
    tier: metadata-service
  spec:
   containers:
   - image: luckyganesh/metadata-service:v2
     name: metac-rs
     env:
     - name: MONGODB_URI
       value: mongodb://mongo/metadata
     ports:
     - containerPort: 8080
```

```
kubectl port-forward metadata-service-9w2jm 8090:8080
```

```
curl http://localhost:8090/metadata
```

```
curl --header "Content-Type: application/json" --request POST --data '{"group":"sunitparekh", "name":"city","value": "Pune"}' "http://localhost:8090/metadata"
```

## Assignment-5

<img width="790" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/a88e4733-4a3e-4060-b981-b6a5925164f0">

```
metadata-service-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: metaservice-deployment
  labels:
    app: metaservice
spec:
  replicas: 2
  selector:
    matchLabels:
      app: metaservice
  template:
    metadata:
      labels:
        app: metaservice
    spec:
      containers:
      - name: metaservice-container
        image: luckyganesh/metadata-service:v1
        ports:
        - containerPort: 8080
```

```
mongodb-deployment.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb-deployment
  labels:
    app: mongodb
spec:
  replicas: 2
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongo-container
        image: mongo
        ports:
        - containerPort: 8080
```

## Assignment-6

<img width="790" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/49949775-d24c-4246-ba88-5bb1beee4102">

## Assignment-7

<img width="788" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/dd7023d8-a9fe-4007-b52c-2432a523c6c5">


## Assignment-8

<img width="787" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/773ca271-d23b-46b1-8dcd-8fe14ea78986">


## Assignment-9

<img width="788" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/cd5c0cd6-7d06-4156-9c08-1df39f3431f3">
