FROM centos/systemd
MAINTAINER Luis Alexandre Deschamps Brandão <techmago@ymail.com>

RUN echo "clean_requirements_on_remove=1" >> /etc/yum.conf
ADD 90-devops.sh /etc/profile.d/90-devops.sh

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y update && \
    yum -y install openssh-server openssh-clients passwd vim wget byobu net-tools rsync pigz pxz sudo && \
    yum clean all && \
    rm -rf /var/cache/yum

ADD sshd_config /etc/ssh/sshd_config

RUN ssh-keygen -A
RUN sudo ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime

ADD ./start.sh /start.sh
RUN bash start.sh && rm -f start.sh
ADD 80-techmago-user /etc/sudoers.d/80-techmago-user
RUN chmod 440 /etc/sudoers.d/*

RUN systemctl enable sshd.service
EXPOSE 22
EXPOSE 80
EXPOSE 433
CMD ["/usr/sbin/init"]
#ENTRYPOINT ["/usr/sbin/init"]
