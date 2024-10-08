# Infracubator Assignments (Kubernetes)

## Assignment-1

1. Create a Pod specification for the metadataservice
   a. image : luckyganesh/metadata-service:v1 (for M1 chip - luckyganesh/metadata-service:v1-arm)
   b. Port to be exposed 8080
2. Check the logs
3. Check the Pod IP
4. Hit the POD ip with /metadata url path from either inside minikube ( minikube ssh ) or colima ( colima ssh ) based on
   whatever you are using
5. Describe the POD
6. Exec into the container using `/bin/sh` command.

metadata-service.yaml (Used a different image as the one mentioned in the assignment was crashing)

```
apiVersion: v1
kind: Pod
metadata:
  name: metadata
  labels:
    app: metadata
spec:
  containers:
    - name: metadata
      image: sunitparekh/metadata:v1.0
      ports:
          - containerPort: 8080
```

<img width="1351" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/4f4d9c1b-4547-4b79-8ca2-0349866de27e">

![image](https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/c3d8b825-d909-4cde-ac94-a6d815b886ee)

![image](https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/a6240261-a061-4bb4-ad9c-d8e7107ad2d4)

![image](https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/32b163cf-9102-4dca-9d89-e341d2dc4d8a)

![image](https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/d4f9fcaf-1d3b-4103-81dc-db2c04e0ded1)

![image](https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/00f3fa70-89de-4b77-b096-b666a38d6e7c)


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

```
mongodb-deployment.yaml

apiVersion: v1
kind: Pod
metadata:
 name: mongo-pod
 labels:
   db: mymongodb
spec:
 containers:
 - name: mongo-container
   image: mongo
   ports:
   - containerPort: 8080
   volumeMounts:
   - mountPath: /data/db
     name: mongo-volume
 volumes:
 - name: mongo-volume
   hostPath:
    path: /data
    type: DirectoryOrCreate
```

```
metadata.yml

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: metadata
  name: metadata
spec:
  replicas: 1
  selector:
    matchLabels:
      app: metadata
  template:
    metadata:
      labels:
        app: metadata
    spec:
      containers:
        - image: luckyganesh/metadata-service:v2
          name: metadata-service
          env:
            - name: MONGODB_URI
              value: mongodb://mongo/metadata
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
          readinessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
```

```
metadata_svc_nodeport

apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: metadata
  name: metadata
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    run: metadata
  type: NodePort
status:
  loadBalancer: {}
```

```
mongo_svc.yml

apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: mongo
  name: mongo
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
  selector:
    app: mongo
status:
  loadBalancer: {}
```

```
kubectl create -f .
```

Add test data

```
curl --header "Content-Type: application/json" --request POST --data '{"group":"krishanu","name":"city","value":"Kolkata"}' 192.168.59.102:32175/metadata
```

Get inside minikube using ssh and verify presence of data

```
minikube ssh
```

```
cd /data/
```

Get inside mongodb pod using ssh

```
kubectl exec -it mongo-pod -- sh
```

```
cd /data/db
```

```
kubectl delete pod mongo-pod
```

```
curl 192.168.59.102:32175/metadata | jq
```

## Assignment-7

<img width="788" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/dd7023d8-a9fe-4007-b52c-2432a523c6c5">

```
mongodb_deploy.yml

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: mongo
  name: mongo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongo
  strategy: {}
  template:
    metadata:
      labels:
        app: mongo
    spec:
      containers:
        - image: mongo
          name: mongo
          resources: {}
          volumeMounts:
            - name: mongo-persistance
              mountPath: /data/db
      volumes:
        - name: mongo-persistance
          persistentVolumeClaim:
            claimName: hostpath-pvc
status: {}
```

```
pv.yml

kind: PersistentVolume
apiVersion: v1
metadata:
  name: hostpath-pv
  labels:
    type: local
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  storageClassName: standard
  hostPath:
    path: "/tmp/data1"
```

```
kubectl create -f pv.yaml
```

```
kubectl get pv
```

```
pvc.yml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hostpath-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
```

```
kubectl create -f pvc-definition.yaml
```

```
kubectl get pvc
```

```
kubectl port-forward metadata-service-fsg3c 8090:8080
```

```
curl --header "Content-Type: application/json" --request POST --data '{"group":"krishanu", "name":"city","value": "Kolkata"}' "http://localhost:8090/metadata"
```

Verify data in PVC

```
minikube ssh
```

```
cd /tmp/data1
```

Verify data inside mongodb pod

```
kubectl exec -it mongo-pod -- sh
```

```
cd /data/db
```

```
kubectl delete pod mongo-pod
```

## Assignment-8

<img width="787" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/773ca271-d23b-46b1-8dcd-8fe14ea78986">

```
config-map.yaml

apiVersion: v1
kind: ConfigMap
metadata:
 name: config-map
data:
 MONGODB_URI: mongodb://mongo/metadata
```

```
metadata.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: metadata
  name: metadata
spec:
  replicas: 1
  selector:
    matchLabels:
      app: metadata
  template:
    metadata:
      labels:
        app: metadata
    spec:
      containers:
        - image: luckyganesh/metadata-service:v2
          name: metadata-service
          env:
            - name: MONGODB_URI
              valueFrom:
                configMapKeyRef:
                  key: MONGODB_URI
                  name: config-map
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
          readinessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
```

```
mongo_deploy.yml

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: mongo
  name: mongo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongo
  strategy: {}
  template:
    metadata:
      labels:
        app: mongo
    spec:
      containers:
        - image: mongo
          name: mongo
          resources: {}
          volumeMounts:
            - name: mongo-persistence
              mountPath: /data/db
      volumes:
        - name: mongo-persistance
          persistentVolumeClaim:
            claimName: hostpath-pvc
status: {}
```

```
kubectl create -f .
```

## Assignment-9

<img width="788" alt="image" src="https://github.com/krishanuc1001/InfracubatorAssignments/assets/40739038/cd5c0cd6-7d06-4156-9c08-1df39f3431f3">

```
echo -n 'mongodb://mongo/metadata'| base64 
```

```
metadata_secret.yaml

apiVersion: v1
data:
  MONGODB_URI: fd4uZ29kYjfgdgL21vbmdvL21ldGFkYXRh
kind: Secret
metadata:
  creationTimestamp: null
  name: metadata-secret
```

```
kubectl create -f metadata_secret.yaml 
```

```
metadata.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: metadata
  name: metadata
spec:
  replicas: 1
  selector:
    matchLabels:
      app: metadata
  template:
    metadata:
      labels:
        app: metadata
    spec:
      containers:
        - image: luckyganesh/metadata-service:v2
          name: metadata-service
          env:
            - name: MONGODB_URI
              valueFrom:
                secretKeyRef:
                  key: MONGODB_URI
                  name: metadata-secret
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
          readinessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
```
