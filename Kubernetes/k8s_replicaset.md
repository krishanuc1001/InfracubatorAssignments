### KUBERNETES REPLICASET

- How to scale PODs?
- What happens when PODs goes down?
- What is missing in PODs?

1) Scalability: How are we going to make multiple PODs of the same application running

2) Reliability: How are we going to bring reliability to the application? 
   If POD goes down, how is it going to come back again? 

We are going to use ``Replicaset`` to address the above concerns.

#### Reason for use of ```Replication Controller``` or ```ReplicaSet```

- What if, for some reason our application crashes and the POD fails, users will no longer be able to access our application? 
  To prevent users from losing access to our application, we would like to have more than one instance or POD running at the same time
  That way, if one fails, we still have our application running on the other one.
  The ```Replication controller``` helps us run multiple instances of a single pot in the Kubernetes cluster, thus providing high availability.

Even if we have a single POD, the ```replication controller``` can help by automatically bringing up a new POD when the existing one fails.
Thus, the ```replication controller``` ensures that the specified number of PODs are running at all times, even if it's just one or 100.

- To create multiple PODs to share the load across them.

For example, in this simple scenario, we have a single POD serving a set of users.
When the number of users increase, we deploy additional POD to balance the load across the two PODs.
If the demand further increases and if we were to run out of resources on the first node, we could deploy additional parts across the other nodes in the cluster.

As we can see, the ```replication controller``` spans across multiple nodes in the cluster. 
It helps us balance the load across multiple PODs on different nodes as well as scale our application when the demand increases.

```Replication Controller``` and ```ReplicaSet```

These are two similar terms ```replication controller``` and ```replica set```.
Both have the same purpose, but they are not the same.

```Replication controller``` is the older technology that is being replaced by ```Replica set```.

```Replica set``` is the new recommended way to set up replication and concepts mentioned above apply to both the technologies

Replicaset is an abstraction over POD which ensures that a specific number of PODs (which are also called as Replicas) are running all the time in the Kubernetes cluster.
It achieves the same using ``Reconciliation Control Loop``. 

The Loop consists of the following 3 stages:

1) ``Observe``: Observe the changes for any changes in desired or current states
2) ``Differentiate``: Figure out the differences between desired and current states
3) ``Act``: Take action to get to the desired state

![image](https://github.com/krishanuc1001/PlaywrightGradleFW/assets/40739038/613b57de-16d5-4341-b6b9-2208128cc629)


#### Job of Replicaset

- Ensure that a POD or Homogeneous set of PODs are always available
- Maintains the desired number of PODs
  - If there are excess PODs, they get killed
  - Launch new PODs in case of failure or deleted or terminated
- Associate with PODs through matching labels 

#### Labels 

```Labels``` are key-value pairs that are attached to objects, such as PODs.

Key and value - both are user defined.

![image](https://github.com/krishanuc1001/PlaywrightGradleFW/assets/40739038/5a0c1db8-3c45-4085-9979-2d9916e51c92)

#### Selectors

```Selectors``` help identifying set of Objects in K8S clusters using 

- Equality-based, or
- Set-based

![image](https://github.com/krishanuc1001/PlaywrightGradleFW/assets/40739038/53acd086-20f4-4896-8c4c-32fba0f072cd)