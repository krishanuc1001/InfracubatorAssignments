### KUBERNETES COMMANDS

1) To run pod named nginx with image nginx

```bash
kubectl run nginx --image=nginx
```

2) To check list and status of all the PODs created

```bash
kubectl get pods
```

3) To extract the pod definition in a yaml file, when there is no POD definition file available for a POD created

```bash
kubectl get pod <pod-name> -o yaml > pod-definition.yaml
```

4) To get more information about a POD created

```bash
kubectl describe pod nginx
```


5) To modify the properties of the pod, you can utilize the below command. 

```bash
kubectl edit pod <pod-name>
```

Please note that only the properties listed below are editable.

- spec.containers[*].image
- spec.initContainers[*].image
- spec.activeDeadlineSeconds
- spec.tolerations
- spec.terminationGracePeriodSeconds

For example, you cannot edit the environment variables, service accounts, resource limits of a running pod. 

But if you really want to, you have 2 options:

a) Run the `kubectl edit pod <pod name>` command. This will open the pod specification in an editor (vi editor). Then edit the required properties. 
When you try to save it, you will be denied. This is because you are attempting to edit a field on the pod that is not editable.

![image](https://github.com/user-attachments/assets/e7e83909-3050-4674-acd7-779b2e30be9b)

A copy of the file with your changes is saved in a temporary location as shown above.

You can then delete the existing pod by running the command:

```bash
kubectl delete pod webapp
```

Then create a new pod with your changes using the temporary file

```bash
kubectl create -f /tmp/kubectl-edit-ccvrq.yaml
```

b) The second option is to extract the pod definition in YAML format to a file using the command

```bash
kubectl get pod webapp -o yaml > my-new-pod.yaml
```

Then make the changes to the exported file using an editor (vi editor). Save the changes

```bash
vi my-new-pod.yaml
```

Then delete the existing pod

```bash
kubectl delete pod webapp
```

Then create a new pod with the edited file

```bash
kubectl create -f my-new-pod.yaml
```


6) To get additional information on the POD being created

```bash
kubectl get pods -o wide
```
7) To get the list of nodes in the cluster

```bash
kubectl get nodes
```

8) To get the list of services in the cluster

```bash
kubectl get services
```

9) To get the list of deployments in the cluster

```bash
kubectl get deployments
```

10) To get the list of replica-sets in the cluster

```bash
kubectl get replicasets
```

11) To get the list of namespaces in the cluster

```bash
kubectl get namespaces
```

12) To create POD with a single container specified in the spec of pod-definition.yml file

```bash
kubectl create -f pod-definition.yml
```

or

```bash
kubectl apply -f pod-definition.yml
```

13) To enter into the POD

```bash
kubectl exec -it nginx -- bash
```

or

```bash
kubectl exec -it nginx -- sh
```

14) Add environment variable to the POD

```bash
kubectl create -f pod-definition-with-version.yml
```

```bash
kubectl exec -it pod-name -- printenv
```

or,

```bash
kubectl exec -it pod-name -- sh
```

```
echo $VERSION
```