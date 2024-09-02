#!/bin/bash
set -x

mkdir -p ~/.fonts/figlet
curl https://raw.githubusercontent.com/xero/figlet-fonts/master/Bloody.flf -o $HOME/.fonts/figlet/Bloody.flf
