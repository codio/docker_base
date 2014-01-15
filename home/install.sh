#!/bin/bash
set -e

# node by nvm install
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
nvm install 0.10
nvm alias default 0.10

#ruby with rbenv install
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
echo 'tlsv1' > ~/.curlrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
export PATH="$HOME/.rbenv/bin:$PATH"
rbenv init -
rbenv install 2.0.0-p353
rbenv global 2.0.0-p353