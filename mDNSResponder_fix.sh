#!/usr/bin/env bash

plist=/System/Library/LaunchDaemons/com.apple.mDNSResponder.plist

sudo -l || exit # don't continue if sudo fails

sudo sed -i .orig 's/\(<string>-launchd<\/string>\)/\1\
                <string>-AlwaysAppendSearchDomains<\/string>/
' $plist
 
sudo launchctl unload -w $plist
 
sudo launchctl load -w $plist
