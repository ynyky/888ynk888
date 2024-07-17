#!/bin/bash

 sudo apt-get update -y

 ## Git ##
 echo '###Installing Git..'
 sudo apt-get install git -y

 git clone https://github.com/metabase/metabase.git

cd metabase
yarn install 
yarn build
yarn build-hot

