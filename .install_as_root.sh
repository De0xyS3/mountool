#!/bin/sh

# Si l'utilisateur est bien root
if [ "$(id -u)" -ne 0 ]
then
	echo "You must be root"
	exit 1
fi


# ------------------------
#  Installation de Conky
#

# Demande confirmation
zenity --question --text="This will install MountIso" --cancel-label=Cancel --ok-label=Continue

# Si l'utilisateur a annulé
if [ $? -ne 0 ]
then
	exit 2
fi

ROOT_DIR="$(dirname "$(readlink -f "$0")")"
DATA_DIR="$ROOT_DIR"/.data
ZENITY_TITLE="MountIso Installer"
LOGFILE=/tmp/mountiso-install.log

# Supression d'un log précédent
rm -f "$LOGFILE"

# Wrapper pour zenity
{
	echo "0"

	# Si l'installation s'est bien passée
	echo "# Installing MountIso files"
	# Copie des fichiers de configurations
	mkdir -p /opt/debiantools >> "$LOGFILE" 2>&1
	install --mode="755" --owner="root" --group="root" "$DATA_DIR"/mountiso.desktop  /usr/share/applications >> "$LOGFILE" 2>&1
	install --mode="755" --owner="root" --group="root" "$DATA_DIR"/mountiso.sh     /opt/debiantools              >> "$LOGFILE" 2>&1
	install --mode="755" --owner="root" --group="root" "$DATA_DIR"/mountiso_as_root.sh /opt/debiantools                >> "$LOGFILE" 2>&1
	/usr/bin/update-desktop-database
	echo "100"

	zenity --info  --title="$ZENITY_TITLE" --text="Installation finished"
} | zenity --progress --percentage=0 --title="$ZENITY_TITLE" --text="Installing..." --auto-close --no-cancel

