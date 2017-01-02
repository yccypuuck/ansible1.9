# Latest version of centos
FROM centos:centos7
MAINTAINER Petr Ruzicka <petr.ruzicka@gmail.com>
RUN yum clean all && \
    yum -y install epel-release && \
    yum -y install --enablerepo=epel-testing ansible1.9 ansible-lint openssh-clients python-boto python-dns python-netaddr && \
    yum clean all

# http://www.projectatomic.io/docs/docker-image-author-guidance/
RUN groupadd -r ansible -g 1000 && \
    useradd -u 1000 -r -g ansible -d /home/ansible -s /sbin/nologin -c "Ansible Docker image user" ansible && \
    mkdir /home/ansible && \
    chown -R ansible:ansible /home/ansible

USER ansible

ENV USER=ansible

WORKDIR /home/ansible/ansible_project

# default command:
CMD [ "ansible-playbook" ]
