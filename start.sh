#!/bin/bash
# Create a user to SSH into as.

USER="$1"
USER_PASS="$2"

echo
echo
echo ===========================
echo "ssh-user: ${USER}"
echo "password: ${USER_PASS}"
echo "==========================="
echo
echo

useradd ${USER}
echo -e "${USER_PASS}\n${USER_PASS}" | (passwd --stdin ${USER})
usermod -a -G wheel ${USER}

cat <<EOF >>/etc/sudoers.d/80-${USER}-user
# User rules for luisos
${USER} ALL=(ALL) NOPASSWD:ALL
EOF
