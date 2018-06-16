FROM centos:latest
MAINTAINER Luis Alexandre Deschamps Brandão

RUN echo "clean_requirements_on_remove=1" >> /etc/yum.conf

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
ADD 90-devops.sh profile.d/90-devops.sh

RUN yum -y update
RUN yum -y install openssh-server passwd vim wget byobu net-tools rsync pigz pxz
RUN yum clean all && rm -rf /var/cache/yum

RUN chmod 755 /start.sh
EXPOSE 22
RUN ./start.sh
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
