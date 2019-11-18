# What is this repository?
This repository contains *Docker things* to make it easy for people to spin up their own Treo PIM instance to play with it and explore it's features.


## Installation & Startup

- Make sure that `docker-compose` is installed on your machine
- clone this repository
- `docker-compose up --build -d`
- visit [http://localhost:8080/](http://localhost:8080) and complete setup with:
  - host name: mysqldb
  - database name: treopim
  - usernname: root
  - password: root
- `docker exec -it treopim_docker_treopim_1 /set_id.sh YOURID`

## Stop containers

To stop your containers and preserve all your data run:

```
$ docker-compose stop
```

Make sure you run it in the root directory of this repository.

## Remove data

To reset all data run following commands:

```
$ docker-compose down
$ sudo rm -rf ./data
```

## Access the TreoPIM Container

Use following command to run a bash inside the PIM container:

```
docker exec -it treopim_docker_treopim_1 /bin/bash
```
