
Debian
====================
This directory contains files used to package nudid/nudi-qt
for Debian-based Linux systems. If you compile nudid/nudi-qt yourself, there are some useful files here.

## nudi: URI support ##


nudi-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install nudi-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your nudi-qt binary to `/usr/bin`
and the `../../share/pixmaps/nudi128.png` to `/usr/share/pixmaps`

nudi-qt.protocol (KDE)

