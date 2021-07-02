# Fluentd&Logrotate Container

Custom image from fluentd to make available the monitoring and retain of Wabi Rusia logs.

## Getting Started

This docker image needs to fill the config files located in _conf_ directory with the logs to send to New Relic _(fluentd.conf)_ and rotate to S3 _(aws_rotation.conf)_
### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage


#### Container Usage
Navigate to the folder that contains the Dockerfile and build the container image:
```shell
docker build -t <image-name> .
```
Run a container with the image created:
```shell
docker run -d --name <container-name> -v /var/log:/mnt/log <image-name>
```

How to get a shell started in your container:

```shell
docker exec -it -u root <container-name>
```

#### Volumes

* `/var/log:/<path>/<to>/<logfolder>` - It's necessary to map every logfolder in cluster to common volume. 
We use /var/log host folder to /mnt/log container folder.

#### Useful File Locations

* `/aws` - Contains aws config files to make possible awsuser uploads rotate logs to S3. Needs credentials.
  
* `/conf` - Config files needed to config fluentd and logrotate

* `entrypoint.sh` - Entrypoint for the Dockerfile, needed to start the fluentd daemon.

## Authors

* **Alejandro Bejarano** - *Initial work* 


See also the list of [contributors]() who 
participated in this project.
