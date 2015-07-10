# ssh_proxy.sh

Conditionally tunnels an SSH connection through a SOCKS proxy.

Uses the Mac OS X network location to determine whether we are on the corporate network. Then checks whether the host we are trying to connect to is internal or external.

## Usage

Invoke using a `ProxyCommand` line in an `ssh_config` entry, like so:

    Host server
      HostName server.domain.com
      User admin
      ServerAliveInterval 20
      ProxyCommand ~/.ssh/ssh_proxy.sh %h %p

## Todo

- Make it work with IP addresses as well as host names