#!/bin/bash

if [ ! -f "$1" ] 
then
	zenity --error --title="Mount Iso"  --text="Iso Image not found"
	exit
fi

mount | grep /media/cdrom 
if [ $? -eq 0 ]
then
	zenity --error --title="Mount Iso"  --text="There is already a mounted DVD under /media/cdrom, please eject it first"
	exit
fi

mount -r -o loop "$1" /media/cdrom
if [ $? -eq 0 ]
then
	zenity --info --title="Mount Iso"  --text="Iso file : $1 successfully mounted under /media/cdrom"
	exit
else
	zenity --error --title="Mount Iso"  --text="Failed to run mount command for Iso file $1 under /media/cdrom"
	exit
fi

