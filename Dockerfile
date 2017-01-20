# Latest version of centos
FROM centos:latest
MAINTAINER Petr Ruzicka <petr.ruzicka@gmail.com>

# Update base image
RUN yum -y update; yum clean all

RUN yum -y install epel-release; yum clean all

RUN yum -y install ansible1.9 ansible-lint openssh-clients python-boto python-dns python-netaddr sudo; yum clean all

# http://www.projectatomic.io/docs/docker-image-author-guidance/
# Create user, group and home directory
RUN groupadd -r ansible -g 433 && \
    useradd -u 431 -r -g ansible -d /home/ansible -s /sbin/nologin -c "Ansible Docker image user" ansible && \
    mkdir -p /home/ansible/.ansible

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

WORKDIR /home/ansible/ansible_project

ENTRYPOINT ["/docker-entrypoint.sh"]

# default command:
CMD [ "ansible-playbook" ]
