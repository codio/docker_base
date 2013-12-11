#!/bin/bash

# node by nvm install
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
nvm install 0.10
nvm use 0.10

#ruby with rbenv install


# nginx/apache support


# databases support