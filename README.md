wEMBOSS docker
===================

This docker image extends and distributes the following software:

#### wEMBOSS

- Based on [wEMBOSS project](http://wemboss.sourceforge.net/).
- Based on [EMBOSS project](http://emboss.sourceforge.net/).
- wEMBOSS was designed and implemented by Martin Sarachu and Marc Colet.
- Citation:
> wEMBOSS: a web interface for EMBOSS
Martín Sarachu and Marc Colet
Bioinformatics 2005 21(4):540-541

# Build the image
The docker image for wEMBOSS can be found in the [docker hub](https://hub.docker.com/r/fikipollo/wemboss/). However, you can rebuild is manually by running **docker build**.

```sh
sudo docker build -t wemboss .
```
Note that the current working directory must contain the Dockerfile file.

## Running the Container
The recommended way for running your wEMBOSS docker is using the provided **docker-compose** script that resolves the dependencies and make easier to customize your instance. Alternatively you can run the docker manually.

## Quickstart

This procedure starts wEMBOSS in a standard virtualised environment.

- Install [docker](https://docs.docker.com/engine/installation/) for your system if not previously done.
- `docker run -it -p 8092:80 fikipollo/wemboss`
- wEMBOSS will be available at [http://localhost:8092/](http://localhost:8092/)

## Using the docker-compose file
Launching your wEMBOSS docker is really easy using docker-compose. Just download the *docker-compose.yml* file and customize the content according to your needs. There are few settings that should be change in the file, follow the instructions in the file to configure your container.
To launch the container, type:
```sh
sudo docker-compose up
```
Using the *-d* flag you can launch the containers in background.

In case you do not have the Container stored locally, docker will download it for you.

# Install the image <a name="install" />
You can run manually your containers using the following commands:

```sh
sudo docker run --name wemboss -v /your/data/location/wemboss-data:/data -e ADMIN_USER=youradminuser -e ADMIN_PASS=supersecret -p 8092:80 -d fikipollo/wemboss
```

In case you do not have the Container stored locally, docker will download it for you.

A short description of the parameters would be:
- `docker run` will run the container for you.

- `-p 8092:80` will make the port 80 (inside of the container) available on port 8092 on your host.
    Inside the container a wEMBOSS Webserver is running on port 8092 and that port can be bound to a local port on your host computer.

- `fikipollo/wemboss` is the Image name, which can be found in the [docker hub](https://hub.docker.com/r/fikipollo/wemboss/).

- `-d` will start the docker container in daemon mode.

- `-e VARIABLE_NAME=VALUE` changes the default value for a system variable.
The wEMBOSS docker accepts the following variables that modify the behavior of the system in the docker.

    - **ADMIN_USER**, the name for the admin account. Using this account you can access to the admin portal (e.g. [http://yourserver:8092/wEMBOSS/admin](http://yourserver:8092/wEMBOSS/admin)) and manipulate the registered users in the system.
    - **ADMIN_USER**, the password for the admin user.
