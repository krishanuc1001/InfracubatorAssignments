### KUBERNETES REPLICASET

- How to scale PODs?
- What happens when PODs goes down?
- What is missing in PODs?

1) Scalability: How are we going to make multiple PODs of the same application running

2) Reliability: How are we going to bring reliability to the application? 
   If POD goes down, how is it going to come back again? 

We are going to use ``Replicaset`` to answer the questions above.

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

