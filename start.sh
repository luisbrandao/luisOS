#!/bin/bash

__create_user() {
# Create a user to SSH into as.
USER="techmago"
USER_PASS="pass321"

useradd ${USER}
echo -e "${USER_PASS}\n${USER_PASS}" | (passwd --stdin ${USER})
echo ssh ${USER} password: ${USER_PASS}
hostname -i
}

# Call all functions
__create_user
