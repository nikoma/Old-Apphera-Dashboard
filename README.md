# Apphera
## The open source Internet, social media monitoring and social engagement platform  


Apphera is a complete platform, covering the full range of activities you need to cover when planning any kind of social media monitoring, social engagement platform, reputation management or SEO related activities. 

This is the "community" edition which contains basically most of the main component but we have paid much attention to the fact that you might not want to roll it out on 10+ servers but ideally on one machine. 

### Features

* Tracking of online reviews (Qype, Yelp, Pointoo, Hotels.com, Tripadvisor and many more)
* Local and global competitor analysis
* Twitter data mining and engagement
* Facebook
* Keyword tracking for SEO purposes 
* Server monitoring for uptime and site delivery speed
* Agency and reseller tools available (in pro edition)
* Mapping of competitive landscape
* Influencer identification 
* Tracking of Foursquare activity
* Youtube tracking (coming soon)
* 50+ SEO tasks (coming soon)

## Installation
This solution has been tested EXTENSIVELY with Ubuntu 12.04 LTS. I feel it is a great choice for a Linux platform and developing and testing on one platform let's us find issues way faster than dealing with countless pitfalls. Never less it should run fine on CentOS and other platforms as well. 

### Step 1   
The first step to get going is to copy the initial install script on your machine. For simplicity let's just use SCP  
`scp apphera_ubuntu.sh root@YOURSERVER.COM:/home/`

### Step 2
!IMPORTANT - WE WILL UPGRADE THIS SCRIPT WITHIN THE NEXT FEW DAYS. IT IS ONLY USEFUL FOR A PREVIOUS VERSION
Ssh into your server, and chmod +x the apphera_ubuntu.sh script and execute it ./apphera_ubuntu.sh 

### Step 3
a)  
Edit the /etc/apt/sources.list file and add at the end:  `deb http://www.rabbitmq.com/debian/ testing main`  
b)  
`sudo wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc`  
c)  
`sudo apt-key add rabbitmq-signing-key-public.asc`  
d)  
`apt-get update`  
e) 
`sudo apt-get install rabbitmq-server`  
f)  
`sudo rabbitmq-plugins enable rabbitmq_management`  
g)  
`chmod +x apphera_setup.sh`  
j)  
`./apphera_setup.sh`

You are all done! Now you should check if all services are installed correctly:

`sudo service redis-server restart`  
`sudo service rabbitmq-server restart`  

If that all succeeds you need to start a background worker. For production environment they will be running in the background. 
Just install apt-get install screen and start a screen session (which never ends) and run bundle exec sidekiq in the main directory of this platform  

You are ready to give it a shot. In production you want to use unicorn with nginx or other webserver but for now webrick will do:
When in the home directory type  

`rails s -e production`  
You should now see the webserver starting up. 

at http://YOURSERVER:3000   you can see the website with signup etc.  
at http://YOURSERVER:55672  You see the message queue server which is password protected for right now just as test/test


Now you can go ahead and find out what the world of social media thinks about you and your competitors. Have fun!






#### Some things to know about installation

If you don't want to run the automated init scripts or want to use a different database you can do the following:  

1. edit config/database.yml to set your database. PLEASE DO NOT REUSE EXISTING DATABASE NAMES AS THE INIT SCRIPT WILL WIPE IT OUT. 
then issue:  
`rake db:create`  
`rake db:schema:load`  
`rake db:seed`  

Now you should be able to start the application on the command line via:  
`rail s -e production`



## Licensing

Apphera is distributed under a dual license: an open source license, and a commercial license. The open source license under which Apphera is distributed is the Version 3 of the AGPL with the addition that it also applies to SaaS (Software as a service companies). The AGPL is one of the world's most popular open source software license.   

For many users, the AGPLv3 license suits their use of Apphera completely. These users are not distributing proprietary modifications, additions to, or derivatives of Apphera and they do not require the legal protections of a commercial license.  

For other users, the AGPLv3 does not suit their use of Apphera. These users wish to use Apphera in ways, products, markets or have other requirements that are not compatible with the AGPLv3. To satisfy these demands, Apphera, as the worldwide exclusive licensor of Apphera, offers commercial licensing of Apphera.  

A commercial license to Apphera provides customers the legal means both to modify Apphera and to incorporate it into a product, without the obligation of providing the resulting code under the AGPLv3 license. License fees are priced competitively and offer tremendous value for the capabilities delivered. Fees vary depending on the application and the scale of its use. For more information about software licensing, please contact the Apphera Sales department.  

Apphera remains the premier open source social media monitoring and engagement project and development for both Apphera and its components follows the open source model. Apphera provides ongoing commitment and contributions to open source. Apphera's commercial licensing option provides customers with the best possible choice - the innovation and creativity of the open source model, and the protections and flexibility available with traditional, commercial software.  

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request