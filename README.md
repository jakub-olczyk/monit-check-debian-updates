# monit-check-debian-updates

A script for monit monitoring daemon that checks for updates in distros using
APT

This is inspired by the Nagios Plugin check_debian_packages

The logic of this solution relies on the fact that monit can check the status
of programs it executes and later use that for resolving the problems reported

## Configuration

Here is example configuration you can put inside `monitrc`, assuming you have
put the script in the `/opt` directory.

	  check program apt path /opt/check-debian-updates.pl
		if status > 0 then alert

