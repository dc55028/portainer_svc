#! /bin/sh

# echo -n "thatpassword" | docker secret create portainer_password -
# sudo mkdir -p /opt/portainer/data
# sudo cp endpoints.json /opt/portainer/data/

docker service create --name portainer \
 --secret portainer_password \
 --publish 9000:9000 \
 --constraint 'node.role == manager' \
 --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
 --mount type=bind,src=/opt/portainer/data,dst=/data \
 portainer/portainer \
 --admin-password-file '/run/secrets/portainer_password' \
 --external-endpoints '/data/endpoints.json'

# -H unix:///var/run/docker.sock \
