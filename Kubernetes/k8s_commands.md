### KUBERNETES COMMANDS

1) To run pod named nginx with image nginx

```
kubectl run nginx --image=nginx
```

2) To check list and status of all the PODs created

```
kubectl get pods
```

3) To get more information about a POD created

```
kubectl describe pod nginx
```

4) To get additional information on the POD being created

```
kubectl get pods -o wide
```

5) To get the list of nodes in the cluster

```zsh
kubectl get nodes
```

6) To get the list of services in the cluster

```zsh
kubectl get services
```
7) To get the list of deployments in the cluster

```zsh
kubectl get deployments
```

8) To get the list of replica-sets in the cluster

```zsh
kubectl get replicasets
```
9) To get the list of namespaces in the cluster

```zsh
kubectl get namespaces
```

10) To create POD with a single container specified in the spec of pod-definition.yml file

```
kubectl create -f pod-definition.yml
```

or

```
kubectl apply -f pod-definition.yml
```

11) To enter into the POD

```
kubectl exec -it nginx -- bash
```

or

```
kubectl exec -it nginx -- sh
```

12) Add environment variable to the POD

```
kubectl create -f pod-definition-with-version.yml
```

```
kubectl exec -it pod-name -- printenv
```

or,

```
kubectl exec -it pod-name -- sh
```

```
echo $VERSION
```