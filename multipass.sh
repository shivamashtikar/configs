 sudo snap install multipass
 multipass launch --name ubuntu-automation
 multipass list
 multipass info ubuntu-automation
 multipass stop ubuntu-automation
 multipass set local.ubuntu-automation.disk=64G
 multipass set local.ubuntu-automation.cpus=4
 multipass set local.ubuntu-automation.memory=8G
 multipass mount $HOME/workspace ubuntu-automation
 multipass start ubuntu-automation
 multipass exec ubuntu-automation -- bash

