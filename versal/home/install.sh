#!/bin/bash
#set -e
echo $HOME

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.parts/autoparts/bin:$PATH"
eval "$(parts init -)"

npm install -g https://github.com/Versal/sdk/tarball/feature/codio-init.zip
npm install -g bower
parts update
parts install zip