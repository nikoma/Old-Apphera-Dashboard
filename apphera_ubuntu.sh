PLEASE DO NOT USE YET





#!/bin/bash
echo "Beginning with Apphera Community edition 2.0. installation. DIAGNOSTICS"
echo "------------------"
echo "Memory information"
free -m
echo "Disk information"
df -h
echo "System rescources seem sufficient for Apphera system - Congratulations"
echo "END DIAGNOSICS"
sleep 2
echo "------------------"
echo "Making sure system is up to date"
sudo apt-get update
sudo apt-get -y upgrade
echo "System up to date"
echo "------------------"
echo "adding debian repo"
sleep 1
sudo cat 'deb http://www.rabbitmq.com/debian/ testing main' >> /etc/apt/sources.list  
echo "deb repo added"
echo "Getting public repo key"
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
echo "adding key"
sudo apt-key add rabbitmq-signing-key-public.asc
echo "------------------"
echo "updating package list"
sudo apt-get update
echo "Installing RabbitMQ message queue server and adding the needed service scripts"
echo "------------------"
sudo apt-get -y install rabbitmq-server
echo "done"
echo "Still all packages up to date?"
sudo apt-get update
sudo apt-get upgrade
echo "very good - let's install some monitoring for RabbitMQ"
rabbitmq-plugins enable rabbitmq_management
echo "Done: Username is by the way guest/guest, you should change that or firewall your server - Well, anyways a good idea!"
echo "starting message queue"
echo "------------------"
sudo service rabbitmq restart
echo "we will now add a user deployer - please answer a couple simple questions about it"
sudo adduser apphera
echo "Horray! Done!"
echo "let's install the newest stable MySQL server as core DB for Apphera"
sudo apt-get -y install postgresql-9.1 libpq-devecho "done!"
echo "------------------"
echo "Lets install GIT as we use that to pull the newest version from github"
sudo apt-get -y install git
sudo chown -R apphera:apphera /home/apphera/
cd /home/deployer 

git clone https://github.com/apphera/social-media-open-source.git
echo "everything there"
echo "Installing Ruby now:"
sudo apt-get -y install ruby1.9.1 ruby1.9.1-dev \
  rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
  build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
         --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
                        /usr/share/man/man1/ruby1.9.1.1.gz \
        --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
        --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
        --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1
 
sudo update-alternatives --config ruby
sudo update-alternatives --config gem

echo "and the Ruby version is:"
ruby --version
echo "congratulations!"
echo "Now redis server to get Resque message queue to work"
sudo apt-get -y install redis-server
echo "Installing bundler now to get all the gems/modules for Apphera system"
cd /home/deployer/apphera
sudo apt-get -y install libxml2-dev 
sudo apt-get -y install libxslt-dev
sudo gem install bundler
cd /home/apphera/apphera
echo "Done!"
echo "--------------------"
cd /home/apphera/apphera
echo "This might take a while - Installing search cluster - Get a coffee"
bundle install
echo "done!"
echo "--------------------"
echo "Now the final touches"
cd /home/apphera/apphera




