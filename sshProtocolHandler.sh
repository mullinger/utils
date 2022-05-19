#!/bin/sh
# Script that opens ssh:// links from Firefox - CC0 by Juhani, www.naskali.fi
# Updated and extended by Max Ullinger

# extract the protocol
proto="$(echo $1 | grep -oP '^[a-z]*')" # first letters
# extract the user (if any)
user="$(echo $1 | grep -oP '(?<=:\/\/)(.*)(?=@)')" # text in between :// and @
# extract the host
host="$(echo $1 | grep -oP '(?<=:\/\/|@)([a-z0-9\.\-]+)(?!.*@)')" # alphanumerals preceded by :// or @, not followed by text@
# extract the port
port="$(echo $1 | grep -oP '(?<=:)\d*')" # numbers after :

command="$proto "
if [ -n "$port" ]
then
	command="${command}-p $port "
fi
if [ -n "$user" ]
then
	command="${command}${user}@"
fi
command="${command}$host"

/usr/bin/gnome-terminal -q --tab -- /bin/bash -c "echo \"Execute command '$command'? ('yes')\";read confirmation; if [ \"\$confirmation\" == \"yes\" ]; then $command; fi; read "

# You also need the boolean 'network.protocol-handler.expose.ssh':false in Firefox's about:config
# Add script to ~/bin/, make executable
# When clicking on ssh:// links firefox should ask which application should handle the link
# Select this script. The script will then run
