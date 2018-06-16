#!/bin/bash

__create_user() {
# Create a user to SSH into as.
useradd techmago
SSH_USERPASS=oran
echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin user)
echo ssh user password: $SSH_USERPASS
hostname -i
}

# Call all functions
__create_user
