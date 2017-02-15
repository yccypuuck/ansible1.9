# Latest version of centos
FROM centos:latest
MAINTAINER Petr Ruzicka <petr.ruzicka@gmail.com>

# Update base image
RUN yum -y update; yum clean all

RUN yum -y install epel-release; yum clean all

RUN yum -y install ansible1.9 ansible-lint openssh-clients python-boto python-dns python-netaddr sudo; yum clean all

RUN groupadd -r ansible -g 433 && \
    useradd -u 431 -r -g ansible -d /home/ansible -s /sbin/nologin -c "Ansible Docker image user" ansible && \
    mkdir -p /home/ansible/.ansible/{tmp,cp}

ENV HOME=/home/ansible
ENV USER=ansible

USER root

VOLUME /home/ansible/ansible_project

WORKDIR /home/ansible/ansible_project

# default command:
CMD [ "ansible-playbook" ]
