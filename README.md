# Custom-Nier-Boot

#I haven't actually run these before so it may not work but should give a rough idea on how to configure most parts. I have only done this for Arch Linux with Wayland, not sure how other distros will work with these steps

#Move Grub Theme to GRUB directory
mv ./"Grub Theme"/Yorha-UI /boot /boot/grub/themes/
#Add or update the following in /etc/default/grub
GRUB_THEME="/boot/grub/themes/Yorha-UI/theme.txt"
#The below one isn't necessarily required but theme is only designed for 1080p for now so this is easiest way to work for 4k screens too, shouldn't be too difficult to reposition assets to make it look good for up to 4k though
GRUB_GFXMODE=1920x1080
#Reload grub with new  values above (Pretty sure other linux distros have own commands for this)
grub-mkconfig -o /boot/grub/grub.cfg


#Move Plymouth Theme to plymouth themes directory
mv ./"Plymouth Theme"/yorha /usr/share/plymouth/themes/

#Creates and enables systemctl service that will keep the boot menu for some time and push logs to the plymouth screen display (will try to enhance in future from fixed time delay to quiting screen once all operations that can be complete are)
mv ./"Plymouth Theme"/feed-plymouth-logs.service /etc/systemd/system/
mv ./"Plymouth Theme"/plymouth-wait-and-log.sh /usr/local/bin/
systemctl --enable feed-plymouth-logs.service

#Creates and enables systemctl service that will play a set of music tracks while in the display manager for log in (shuffles tracks and doesn't loop)
mv ./"SDDM Custom"/sddm-music.service /etc/systemd/system/
mv ./"SDDM Custom"/sddm-music.sh /usr/local/bin/
mv ./"SDDM Custom"/sddm-startup.wav /usr/share/sounds/
systemctl --enable sddm-music.service 
#Allows user to stop above service (Otherwise music will continue after login)
mv ./"SDDM Custom"/49-stop-sddm-music.rules /etc/polkit-1/rules.d/
#Depending on if you are on Wayland or X add below line to either /usr/share/sddm/scripts/ or /usr/share/sddm/scripts/  (No harm in adding to both if unsure) add at top just below the shebang (#!/bin/sh)
systemctl stop sddm-music.service

#Place any music that you want to be played on login screen
/usr/share/sounds/sddm-music/ 
