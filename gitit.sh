#!/bin/bash

# TODO: Add some error handling

# Read settings in .gitit-config file in the home directory
if [ -f ~/.gitit-config ]; then 
	source ~/.gitit-config
	# ssh into the box using git user (from the settings file)
	dirname="basename $(pwd)"
	c="mkdir $($dirname)"
	url="ssh $user@$host -p $port"
	
	# Remotely
	$url "mkdir $($dirname) && cd $($dirname) && git --bare init && exit"
	
	# Locally
	git init .
	git add .
	git commit -am 'initial commit'
	git remote add origin ssh://$user@$host:$port/$path/$($dirname)
	git push origin master
	
	exit 0
else
	# If file doesn't exit
	echo 'Please create ~/.gitit-config'
	exit 1
fi
