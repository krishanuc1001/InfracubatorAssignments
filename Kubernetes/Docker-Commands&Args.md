### Docker Commands Overview:
Containers run specific processes (e.g., web server, database) and exit when the process ends.
Unlike VMs, containers are not meant to host an OS; they serve to run tasks.

### CMD Instruction:
CMD specifies the default command to run when a container starts.
For example, the nginx image uses `nginx` as its CMD, while MySQL uses `mysqld`.
If a container (like Ubuntu) runs with no specific task, it will exit immediately after running the default command (like `bash`).

### Overriding Commands:

You can override the default command by appending a command to docker run:
    
```bash
docker run ubuntu sleep 5
```

This command runs sleep for 5 seconds instead of the default bash command.

### Permanent Command Override:

To always run a specific command in an image, create a new Docker image with the desired command using the CMD instruction:

```bash
CMD ["sleep", "5"]
```

The command should be in an array format, separating the executable (sleep) and the argument (5).

### ENTRYPOINT Instruction:

ENTRYPOINT defines the default executable, while parameters can be passed at runtime.

```bash
ENTRYPOINT ["sleep"]
```

The difference between CMD and ENTRYPOINT:

- CMD is completely replaced if parameters are passed via the command line.

- ENTRYPOINT allows parameters to be appended rather than replacing the executable.

### Using Both CMD and ENTRYPOINT:

- How do we configure a default value for the command if one has not specified in the command line? 

Use both ENTRYPOINT to define the base command (e.g., sleep), and CMD to provide default parameters (e.g., 5 seconds):

```bash
FROM ubuntu
ENTRYPOINT ["sleep"]
CMD ["5"]
```

If no argument is passed, it runs sleep 5, by default. 

```bash
docker run ubuntu-sleeper
```

If an argument is passed (e.g., 10), it overrides the CMD:

```bash
docker run ubuntu-sleeper 10
```

Note: We should always specify the `ENTRYPOINT` and `CMD` instructions in JSON array format.

### Overriding ENTRYPOINT:

- What if we want to modify the `ENTRYPOINT` at the run-time from `sleep` to an imaginary command `sleep2.0`?

You can override the ENTRYPOINT during runtime using the `--entrypoint` option in docker run:

```bash
docker run --entrypoint sleep2.0 ubuntu-sleeper 10
```