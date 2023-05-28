### KUBERNETES COMMANDS

1. To run pod named nginx with image nginx

```
kubectl run nginx —image=nginx
```

2. To check status of all the PODs created

```
kubectl get pods
```

3. To get more information about a POD created

```
kubectl describe pod nginx
```

4. To get additional information on the POD being created

```
kubectl get pods -o wide
```

5. To create POD with a single container specified in the spec of pod-definition.yml file

```
kubectl create -f pod-definition.yml
```

or

```
kubectl apply -f pod-definition.yml
```