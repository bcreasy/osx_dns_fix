#!/usr/bin/env bash

plist=/System/Library/LaunchDaemons/com.apple.mDNSResponder.plist

if [[ $(uname -s) != "Darwin" ]]; then
  echo "Error: Must be run in OSX Lion or above"
  exit 1
fi

kernel=$(uname -r)

if [[ $1 == "--debug" ]]; then
  debug=1
  plist=plist/com.apple.mDNSResponder.plist.$kernel
  if [ ! -e $plist ]; then
    echo "Error: Mock plist not found for kernel version ${kernel}.  Create one based off of the default installation for this version of OSX before debugging can be used."
    exit 1
  fi
fi

sudo -l || exit # don't continue if sudo fails

case "$kernel" in
  11.*) # lion
    sudo sed -i.orig 's/\(<string>-launchd<\/string>\)/\1\
               <string>-AlwaysAppendSearchDomains<\/string>/
' $plist
    ;;
  12.*) # mountain lion
    sudo sed -i.orig 's/\(<string>-launchd<\/string>\)/\1\
               <string>-AlwaysAppendSearchDomains<\/string>/
' $plist
    ;;
  13.*) # mavericks
    sudo sed -i.orig 's/\(<string>\/usr\/sbin\/mDNSResponder<\/string>\)/\1\
               <string>-AlwaysAppendSearchDomains<\/string>/
' $plist
    ;;
  *)
    echo "Unsupported OS kernel version ($kernel). Exiting."
    exit 1
esac

if [[ -z $debug ]]; then
  sudo launchctl unload -w $plist
  sudo launchctl load -w $plist
fi
