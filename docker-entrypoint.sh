#!/bin/bash -e

# This is needed, because ansible 1.9 is caching the facts about the remote systems to ~/.ansible/tmp/ (this can not be changed in this ansible version).
# Therefore you need to run the the ansible as the user who executes the docker image.
# It will ensure that all facts gathered by dockerized ansible sored in docker's /home/ansible/.ansible/tmp/ will be properly placed to the user's home directory ~/.ansible/tmp/ with correct uid/gid.
# Without this hook ansible will write it's temporary data with unknown uid/gid to the user's ~/.ansible/tmp/.

MY_UID=$(stat -c %u /home/ansible/ansible_project)
MY_GID=$(stat -c %g /home/ansible/ansible_project)

# Change gui/uid of ansible user
groupmod --gid $MY_GID ansible
usermod --uid $MY_UID --gid $MY_GID ansible
chown ansible:ansible /home/ansible /home/ansible/.ansible

sudo -H -E -u ansible "$@"
