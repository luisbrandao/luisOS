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

ENV container docker
# Enable systemd for use
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
# VOLUME [ "/sys/fs/cgroup" ]

ADD ./start.sh /start.sh
RUN bash start.sh && rm -f start.sh
ADD 80-techmago-user /etc/sudoers.d/80-techmago-user
RUN chmod 440 /etc/sudoers.d/*

RUN systemctl enable sshd.service
CMD ["/usr/sbin/init"]
#ENTRYPOINT ["/usr/sbin/init"]
