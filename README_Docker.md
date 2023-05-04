# Infracubator Assignments (Docker)

## Assignment-1

1. Start an nginx container.
2. Port forward to local and check.
3. Check logs.
4. Go inside the container.
5. Stop the container.

![img.png](img.png)

![img_1.png](img_1.png)

![img_2.png](img_2.png)

![img_3.png](img_3.png)

![img_4.png](img_4.png)

![img_5.png](img_5.png)

## Assignment-2

Given that you have instructions to run the go-app (in pre-requisites)
1. Try to create a docker image out of it with the base image of golang:alpine
2. Run a container with that image and do a curl a request and make sure you are able to see the output.
3. Tag the docker image with v1.
4. Run docker history, observe and understand the output.
5. Push the docker image to your dockerhub.

![img_6.png](img_6.png)

![img_7.png](img_7.png)

![img_8.png](img_8.png)

![img_9.png](img_9.png)

![img_10.png](img_10.png)

![img_11.png](img_11.png)

![img_12.png](img_12.png)

![img_13.png](img_13.png)

![img_14.png](img_14.png)

![img_15.png](img_15.png)


## Assignment-3
1. Create multistage build and run Dockerfile for go -app
- Stage 1 : Build
- Stage 2 : Run

![img_33.png](img_33.png)

![img_34.png](img_34.png)

![img_35.png](img_35.png)

## Assignment-4
1. Create  a volume  call it as my-volume
2. Create a container and attach it to my-volume
3. Change something in the volume folder and add a file with some content.
4. Create a second container mounted with same volume . Check if the file exists or not.

![img_19.png](img_19.png)

![img_20.png](img_20.png)

![img_21.png](img_21.png)

![img_22.png](img_22.png)

![img_23.png](img_23.png)

![img_24.png](img_24.png)

![img_25.png](img_25.png)

![img_26.png](img_26.png)

![img_27.png](img_27.png)

![img_28.png](img_28.png)

![img_29.png](img_29.png)

![img_30.png](img_30.png)

![img_31.png](img_31.png)

![img_32.png](img_32.png)



## Assignment-5
1. Create docker-compose file for go-app
2. docker-compose up
3. Use / endpoint to check the service running
4. Use /vote endpoint to add vote
5. docker-compose down

![img_16.png](img_16.png)

![img_17.png](img_17.png)

This is a Docker Compose YAML file that defines a service called `app`.

`version: '3'` specifies the version of the Docker Compose file syntax.

Under `services`, the `app` service is defined with the following properties:

- `container_name: my_go_app`: sets the name of the container to `my_go_app`. This is optional, but can be useful for easier container management.
- `build`: specifies how to build the Docker image for the service. It has two properties:
    - `context: .`: sets the build context to the current directory (`.`). This is the directory from which the build context is sent to the Docker daemon.
    - `dockerfile: Dockerfile3`: specifies the Dockerfile name to use for building the image. This file should be present in the build context.
- `ports`: maps the container's port `8080` to the host's port `8080`. This allows the service to be accessible from outside the Docker container.
- `volumes`: mounts the current directory `.` as a volume in the container at the path `/go/src/my_app`. This allows changes made to the source code on the host machine to be reflected in the container.
- `environment`: sets an environment variable `PORT` to `8080`. This environment variable can be used in the application code to set the port on which the application listens.

Overall, this Docker Compose file is defining a service that builds a Docker image from a specified Dockerfile, runs the image in a container with a specified container name, exposes the container's port `8080` to the host's port `8080`, mounts the current directory as a volume in the container, and sets an environment variable `PORT` to `8080`.


![img_18.png](img_18.png)

![img_36.png](img_36.png)

![img_37.png](img_37.png)

![img_38.png](img_38.png)

![img_39.png](img_39.png)

![img_40.png](img_40.png)
