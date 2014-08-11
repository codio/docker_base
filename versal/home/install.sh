#!/bin/bash
#set -e
echo $HOME

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.parts/autoparts/bin:$PATH"
eval "$(parts init -)"

npm install -g git://github.com/Versal/sdk
npm install -g bower
parts update
parts install zip