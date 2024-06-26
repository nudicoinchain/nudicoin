Sample init scripts and service configuration for nudid
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/nudid.service:    systemd service unit configuration
    contrib/init/nudid.openrc:     OpenRC compatible SysV style init script
    contrib/init/nudid.openrcconf: OpenRC conf.d file
    contrib/init/nudid.conf:       Upstart service configuration file
    contrib/init/nudid.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "nudicore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes nudid will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, nudid requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, nudid will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that nudid and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If nudid is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running nudid without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/nudi.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/nudid`  
Configuration file:  `/etc/nudicore/nudi.conf`  
Data directory:      `/var/lib/nudid`  
PID file:            `/var/run/nudid/nudid.pid` (OpenRC and Upstart) or `/var/lib/nudid/nudid.pid` (systemd)  
Lock file:           `/var/lock/subsys/nudid` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the nudicore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
nudicore user and group.  Access to nudi-cli and other nudid rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/nudid`  
Configuration file:  `~/Library/Application Support/NudiCore/nudi.conf`  
Data directory:      `~/Library/Application Support/NudiCore`
Lock file:           `~/Library/Application Support/NudiCore/.lock`

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start nudid` and to enable for system startup run
`systemctl enable nudid`

### OpenRC

Rename nudid.openrc to nudid and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/nudid start` and configure it to run on startup with
`rc-update add nudid`

### Upstart (for Debian/Ubuntu based distributions)

Drop nudid.conf in /etc/init.  Test by running `service nudid start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy nudid.init to /etc/init.d/nudid. Test by running `service nudid start`.

Using this script, you can adjust the path and flags to the nudid program by
setting the NUDID and FLAGS environment variables in the file
/etc/sysconfig/nudid. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.nudi.nudid.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.nudi.nudid.plist`.

This Launch Agent will cause nudid to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run nudid as the current user.
You will need to modify org.nudi.nudid.plist if you intend to use it as a
Launch Daemon with a dedicated nudicore user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
