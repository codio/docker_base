#!/bin/bash
set -e
mkdir -p $HOME/.ssh

# node by nvm install
curl https://raw.githubusercontent.com/creationix/nvm/v0.10.0/install.sh | bash
[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh
nvm install 0.10
nvm alias default 0.10

#ruby with rbenv install
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
echo 'cd $HOME/workspace/' >> ~/.bash_profile
echo 'tlsv1' > ~/.curlrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 2.0.0-p353
rbenv install 1.9.3-p484
rbenv install 2.1.0
rbenv global 2.0.0-p353
gem install bundle
ruby -e "$(curl -fsSL https://raw.github.com/codio/boxparts/master/setup.rb)"

npm install -g versal-sdk
rm -rf $HOME/.bash_history
