#!/bin/sh

# Si ce n'est pas un Linux
if [ "$(uname)" != "Linux" ]
then
	echo "This is for Linux only"
	exit 1
fi

# Variables
ROOT_DIR="$(dirname "$(readlink -f "$0")")"
DISTRIB_ID="$(lsb_release -is)"
DISTRIB_CODENAME="$(lsb_release -cs)"

# Si ce n'est pas une Debian Jessie
if [ "$DISTRIB_ID" != "Debian" -o "$DISTRIB_CODENAME" != "jessie" ]
then
	echo "This is for Debian Jessie only"
	exit 1
fi

# Lance l'installation
pkexec env DISPLAY="$DISPLAY" XAUTHORITY="$XAUTHORITY" sh "$ROOT_DIR"/.install_as_root.sh
