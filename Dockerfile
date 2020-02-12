FROM centos:7
MAINTAINER Luis Alexandre Deschamps Brandão <techmago@ymail.com>

# === From oficial systemd docker ==============================================
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
# === From oficial systemd docker ==============================================


ADD 90-devops.sh /etc/profile.d/90-devops.sh

RUN ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime && \
    echo "clean_requirements_on_remove=1" >> /etc/yum.conf && \
    echo "ip_resolve=4" >> /etc/yum.conf && \
    yum-config-manager --add-repo=https://techmago.sytes.net/rpm/techmago-centos.repo && \
    yum-config-manager --disable base updates extras centosplus && \
    yum -y install --nogpgcheck yum-utils && \
    yum -y update && \
    yum -y --nogpgcheck install openssh-server openssh-clients passwd vim wget byobu net-tools rsync pigz pxz sudo bind-utils file && \
    yum clean all && rm -rf /var/cache/yum

ADD sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -A

ADD ./userPrepare.sh /userPrepare.sh
RUN bash userPrepare.sh luisos pass321 && \
    rm -f userPrepare.sh

RUN mkdir -p /home/luisos/.ssh/
ADD authorized_keys /home/luisos/.ssh/authorized_keys
RUN chmod 400 /home/luisos/.ssh/authorized_keys && \
    chown luisos:luisos /home/luisos/.ssh/authorized_keys

RUN systemctl enable sshd.service
EXPOSE 22
EXPOSE 80
EXPOSE 433
CMD ["/usr/sbin/init"]
#ENTRYPOINT ["/usr/sbin/init"]
