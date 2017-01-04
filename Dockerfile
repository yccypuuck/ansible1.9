# Latest version of centos
FROM centos:centos7
MAINTAINER Petr Ruzicka <petr.ruzicka@gmail.com>

# Update base image
RUN yum -y update; yum clean all

RUN yum -y install epel-release; yum clean all

RUN yum -y install ansible1.9 ansible-lint openssh-clients python-boto python-dns python-netaddr; yum clean all

# http://www.projectatomic.io/docs/docker-image-author-guidance/
# Create user, group and home directory
RUN groupadd -r ansible -g 433 && \
    useradd -u 431 -r -g ansible -d /home/ansible -s /sbin/nologin -c "Ansible Docker image user" ansible && \
    mkdir /home/ansible && \
    chown -R ansible:ansible /home/ansible

# Run everything below as the wildfly user
USER ansible

WORKDIR /home/ansible/ansible_project

# default command:
CMD [ "ansible-playbook" ]
