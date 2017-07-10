# Latest version of centos
FROM centos:latest
MAINTAINER Petr Ruzicka <petr.ruzicka@gmail.com>

# Update base image
RUN yum -y update; yum clean all

RUN yum -y install epel-release strace; yum clean all

RUN yum -y install gcc libffi-devel python-devel openssl-devel openssh-clients python-pip python-boto python-dev libxml2-dev libxslt-dev python2-boto3 python-dns python-netaddr sudo; yum clean all
RUN pip install --upgrade pip virtualenv virtualenvwrapper
RUN virtualenv ansible1.9
RUN source ansible1.9/bin/activate
RUN pip install -U ansible==1.9.3 'jinja2<2.9'
RUN pip install redis

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
