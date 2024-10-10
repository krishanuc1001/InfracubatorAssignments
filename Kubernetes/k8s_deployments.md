### Frequently Used Commands


- To create deployment

```bash
kubectl create -f <deployment-definition-name>.yaml
```

- To create deployment with a record for Change-Cause

```bash
kubectl create -f <deployment-definition-name>.yaml --record
```

- To see all the deployments

```bash
kubectl get deployments
```

- To see all the deployments created along with the Replica Sets and PODs

```bash
kubectl get all
```

- To create deployment with name, replicas, and image

```bash
kubectl create deployment <name> --image=<image-name> --replicas=<replicas>
```

- To update/ edit deployment configuration

```bash
kubectl edit deployment myapp-deployment --record 
```

With Deployments, you can easily edit any field/property of the POD template. 
Since the pod template is a child of the deployment specification, with every change the deployment will automatically delete and create a new pod with the new changes. 
So if you are asked to edit a property of a POD part of a deployment you may do that simply by running the command

```bash
kubectl edit deployment my-deployment
```

- To delete deployment

```bash
kubectl delete deployments myapp-deployment
```

- To see the status of Rollout 

```bash
kubectl rollout status deployment/<deployment-name>
```

- To see the revisions and history of the rollouts

```bash
kubectl rollout history deployment/<deployment-name>
```

#************************************************************************************************#

There are 2 types of Deployment Strategy
- Recreate: In this case, the replicas of the webapp instances deployed are destroyed and the newer version of the application instances. 
            The problem with this approach is that during the period after the older versions of the application are down and before any newer version of the application is up, the application is down and inaccessible to users.
            This strategy is not the default deployment strategy. 


- Rolling-update: This is the default Deployment Strategy.
            In this strategy, we do not destroy the all the webapp instances at once, instead we take down the older version and bring up a newer version one by one.
            This way the application never goes down and the upgrade is seamless.

  
#************************************************************************************************#

- To update the image of application to be deployed

Note: Using the below command to update deployment will result in the deployment definition file having a different configuration
      Therefore, we must be careful when using the same definition file to make changes in the future.
```bash
kubectl set image deployment myapp-deployment <container-name>=nginx:1.9.1 --record 
```

- To view detailed information regarding a deployment

```bash
kubectl describe deployment <deployment-name>
```

- To roll back to a previous deployment

```bash
kubectl rollout undo deployment/myapp-deployment
```