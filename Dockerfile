FROM centos:latest
MAINTAINER Luis Alexandre Deschamps Brandão
EXPOSE 22

RUN echo "clean_requirements_on_remove=1" >> /etc/yum.conf

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
ADD 90-devops.sh /etc/profile.d/90-devops.sh

RUN yum -y update
RUN yum -y install openssh-server openssh-clients passwd vim wget byobu net-tools rsync pigz pxz sudo
RUN yum clean all && rm -rf /var/cache/yum

ADD sshd_config /etc/ssh/sshd_config

RUN ssh-keygen -A
RUN sudo ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime

ADD ./start.sh /start.sh
RUN bash start.sh && rm -f start.sh
ADD 80-techmago-user /etc/sudoers.d/80-techmago-user
RUN chmod 440 /etc/sudoers.d/*

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
