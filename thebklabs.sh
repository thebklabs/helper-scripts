#!/bin/bash

# thebklabs.sh --help
# Info: helper script for website build and twitch setup
# source thebklabs.sh // use 'source' we can change directory of the parent shell 

# replace <> with your setup
WEBDIR="<Your Web Site Directory>"
STREAM_VM="<Name of VM>"
TWITCH_DASH="https://www.twitch.tv/<Channel Name>/dashboard/live"

# Get command line arguments
for arg in "$@"
do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
        echo "     NAME
        thebklabs - helper commands for the thebklabs

      OPTIONS
           --help
             display helper information
           -cd, -dir
            change to thebklabs web directory
           -edit,-e
            edit the website with vscode
           -build,-b
            to build and host website locally
           -deploy,-host
            deploy to firebase hosting provider
           -stream
            Starting up my stream"
   
    elif [ "$arg" == "-cd" ] || [ "$arg" == "-dir" ]
    then
        echo "www"
        cd $WEBDIR
   
    elif [ "$arg" == "-stream" ] 
    then
        echo "streaming"
        virtualbox --startvm $STREAM_VM &
        obs &
        firefox -new-window TWITCH_DASH

    elif [ "$arg" == "-edit" ] || [ "$arg" == "-ed" ]
    then
        echo "editing"
        code $WEBDIR
    
    elif [ "$arg" == "-build" ] || [ "$arg" == "-serve" ]
    then
        cd $WEBDIR
        sudo jekyll serve 

    elif [ "$arg" == "-deploy" ] || [ "$arg" == "-host" ]
    then
        cd $WEBDIR
        firebase deploy
    elif [ "$arg" == "-sync" ]
    then
        cd $WEBDIR
        git status
        git stash save --keep-index
	git stash drop
    else
	    echo "Error: othing ran"
    fi
done

return
