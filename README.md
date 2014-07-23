osx_dns_fix
===========

Simple script to fix DNS domain appending in OSX

It will add the -AlwaysAppendSearchDomains command line argument to the mDNSResponder service so that DNS queries properly follow search domains first before looking to external DNS.

Requires sudo(1) permissions.

To apply the patch, run the script from your terminal:
```
./mDNSREsponder_fix.sh
```

Supported OSX versions: lion, mountain lion, mavericks
