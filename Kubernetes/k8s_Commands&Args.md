### Pod Definition Basics:

In Kubernetes, commands and arguments can be specified in the pod definition file.

When creating a pod from an image (e.g., Ubuntu Sleeper), the container will execute the default command (e.g., sleeping for 5 seconds).

### Overriding CMD with Arguments:

To pass additional arguments (e.g., to make the container sleep for 10 seconds), the args field in the pod definition is used.

This overrides the CMD instruction in the Docker image.

Example in the pod definition file:

```yaml
args: ["10"]
```

<img width="1096" alt="image" src="https://github.com/user-attachments/assets/fa443a3a-d989-4c26-8528-76ad1bc5d79f">


### ENTRYPOINT vs CMD in Kubernetes:

In a `Dockerfile`:
- `ENTRYPOINT` defines the command that runs when the container starts.
- `CMD` provides default parameters for that command.

In Kubernetes pod-definition yaml:
- The command field in the pod definition file corresponds to `ENTRYPOINT` in Docker.
- The args field in the pod definition file corresponds to `CMD` in Docker.

### Overriding ENTRYPOINT:
To override the ENTRYPOINT in a Docker image (e.g., changing from sleep to sleep2.0), you use the command field in the pod definition.
Example in the pod definition file:

```yaml
command: ["sleep2.0"]
```

<img width="1115" alt="image" src="https://github.com/user-attachments/assets/8f5ca13c-bdcf-4676-9c2d-3ee18a73b636">

### Key Summary:

- `command` in the Kubernetes pod definition overrides the `ENTRYPOINT` in Dockerfile.
- `args` in the Kubernetes pod definition overrides the `CMD` in Dockerfile.

<img width="1121" alt="image" src="https://github.com/user-attachments/assets/71eb88dc-75e2-4cbe-9aae-ed839ea89659">