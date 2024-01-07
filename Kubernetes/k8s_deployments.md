### Frequently Used Commands


- To create deployment

```
kubectl create -f <deployment-definition-name>.yaml
```

- To create deployment with a record for Change-Cause

```
kubectl create -f <deployment-definition-name>.yaml --record
```

- To see all the deployments

```
kubectl get deployments
```

- To see all the deployments created along with the Replica Sets and PODs

```
kubectl get all
```

- To create deployment with name, replicas, and image

```
kubectl create deployment <name> --image=<image-name> --replicas=<replicas>
```

- To update/ edit deployment configuration

```
kubectl edit deployment myapp-deployment --record 
```

- To delete deployment

```
kubectl delete deployments myapp-deployment
```

- To see the status of Rollout 

```
kubectl rollout status deployment/<deployment-name>
```

- To see the revisions and history of the rollouts

```
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
```
kubectl set image deployment myapp-deployment <container-name>=nginx:1.9.1 --record 
```

- To view detailed information regarding a deployment

```
kubectl describe deployment <deployment-name>
```

- To roll back to a previous deployment

```
kubectl rollout undo deployment/myapp-deployment
```