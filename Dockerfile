FROM centos:latest
MAINTAINER Luis Alexandre Deschamps Brandão
EXPOSE 22

RUN echo "clean_requirements_on_remove=1" >> /etc/yum.conf

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
ADD 90-devops.sh profile.d/90-devops.sh

RUN yum -y update
RUN yum -y install openssh-server passwd vim wget byobu net-tools rsync pigz pxz
RUN yum clean all && rm -rf /var/cache/yum

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN ./start.sh
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
