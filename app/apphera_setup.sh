#!/bin/bash
# Apphera Setup, (c) 2012, Nikolai Manek
echo "This script sets up a NEW Apphera installation. Under NO circumstanced use on existing Apphera install. IT WILL DELETE ALL DATA!"
echo "now running rake db:create. If not existing the databases will be created. If they already exist and have ANY data in it you should better stop now..."
rake db:create
echo "now loading DB schema."
rake db:schema:load
echo "seeding database"
rake db:seed
