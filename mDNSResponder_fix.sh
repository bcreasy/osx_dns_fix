#!/usr/bin/env bash

plist=/System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
if [[ $1 == "--debug" ]]; then
  debug=1
  plist=plist/com.apple.mDNSResponder.plist
fi

sudo -l || exit # don't continue if sudo fails

sudo sed -i .orig 's/\(<string>\/usr\/sbin\/mDNSResponder<\/string>\)/\1\
                <string>-AlwaysAppendSearchDomains<\/string>/
' $plist

if [[ -z $debug ]]; then
  sudo launchctl unload -w $plist
  sudo launchctl load -w $plist
fi
