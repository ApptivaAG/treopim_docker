# What is this repository?

This repository contains *Docker things* to make it easy for people to spin up their own Treo PIM instance to play with it and explore it's features.

## Start the docker container

In order to spin up your own instance you need to have `docker-compose` installed.

### Start your containers

To start a container, clone this repository, cd into the root directory and run this command:

```
$ docker-compose up -d
```

It will start two containers: A MySQL instance and an apache with Treo PIM. The Data for the MySQL database is stored in the directory `mysql_data` which is created in the root directory of your repository.

After starting Treo PIM you need to go through the installation wizard at [http://localhost:8080/](http://localhost:8080/). There you enter following data:

- db host: mysqldb
- db name: treo
- db user: root
- db password: my-secret-pw

Later in the wizard you can choose your own user and password to access Treo PIM.

### Stop your containers

To stop your containers and preserve all your data run:

```
$ docker-compose stop
```

Make sure you run it in the root directory of this repository.

To run it again you simply run:

```
$ docker-compose up -d
```

### Rebuild your containers

To reset everything and start over run following commands:

```
$ docker-compose down
$ rm -rf ./mysql_data
$ docker-compose up -d --build
```

# Access the TreoPIM Container

Use following command to run a bash inside the PIM container:

```
docker exec -it treopim_docker_treopim_1 /bin/bash
```

# TODO

We need a solution for cron jobs as it is not usual to run a cron daemon in a docker container.