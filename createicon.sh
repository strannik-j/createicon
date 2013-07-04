#!/bin/bash

fbin=""					# without game.sh
exe=mm8.exe				# without "wine ". Only "*.exe --command".
exe2=MM8Setup.Exe			# without "wine ". Only "*.exe --command".
gdesktop=mm8 			# without ".desktop"
gdesktop2=mm8-setup
dname="Меч и Магия VIII"
dname2="MM8 - setup"
dcomment="Linux-версия игры "$dname
dversion=1
dcategories='Game;ArcadeGame;'
wversion=1.3.10

# First game.sh
echo '#!/bin/bash' > $fbin\game.sh
echo 'PATH="'$PWD'/wine/usr/bin/:$PATH"' >> $fbin\game.sh
echo 'export WINEPREFIX="'$PWD'/prefix"' >> $fbin\game.sh
echo 'export WINEDEBUG="-all"' >> $fbin\game.sh
echo 'cd '\"$PWD$''\/$fbin\" >> $fbin\game.sh
echo 'wine' $exe >> $fbin\game.sh
chmod a+x $fbin\game.sh

#Second game.sh
echo '#!/bin/bash' > $fbin\game2.sh
echo 'PATH="'$PWD'/wine/usr/bin/:$PATH"' >> $fbin\game2.sh
echo 'export WINEPREFIX="'$PWD'/prefix"' >> $fbin\game2.sh
echo 'export WINEDEBUG="-all"' >> $fbin\game2.sh
echo 'cd '\"$PWD$''$fbin\" >> $fbin\game2.sh
echo 'wine' $exe2 >> $fbin\game2.sh
chmod a+x $fbin\game2.sh

# winecfg
echo '#!/bin/bash' > wine/winecfg.sh
echo 'PATH="'$PWD'/wine/usr/bin/:$PATH"' >> wine/winecfg.sh
echo 'export WINEPREFIX="'$PWD'/prefix"' >> wine/winecfg.sh
echo 'export WINEDEBUG="-all"' >> wine/winecfg.sh
echo 'wine winecfg' >> wine/winecfg.sh
chmod a+x wine/winecfg.sh

# winetricks
echo '#!/bin/bash' > wine/winetricks.sh
echo 'PATH="'$PWD'/wine/usr/bin/:$PATH"' >> wine/winetricks.sh
echo 'export WINEPREFIX="'$PWD'/prefix"' >> wine/winetricks.sh
echo 'export WINEDEBUG="-all"' >> wine/winetricks.sh
echo 'cd '\"$PWD$'/'wine\" >> wine/winetricks.sh
echo 'sh winetricks' >> wine/winetricks.sh
chmod a+x wine/winetricks.sh

# First .desktop file
echo '[Desktop Entry]' > $gdesktop.desktop
echo 'Name='$dname >> $gdesktop.desktop
echo 'Exec=sh '\"''$PWD'/'$fbin'game.sh'\" >> $gdesktop.desktop
echo 'Type=Application' >> $gdesktop.desktop
echo 'Comment='$dcomment >> $gdesktop.desktop
echo 'Categories='$dcategories >> $gdesktop.desktop
echo 'StartupNotify=true' >> $gdesktop.desktop
echo 'Icon='$PWD'/ico.png' >> $gdesktop.desktop
echo 'Version='$dversion >> $gdesktop.desktop
chmod a+x $gdesktop.desktop

 Second .desktop file
echo '[Desktop Entry]' > $gdesktop2.desktop
echo 'Name='$dname2 >> $gdesktop2.desktop
echo 'Exec=sh '\"''$PWD'/'$fbin'game2.sh'\" >> $gdesktop2.desktop
echo 'Type=Application' >> $gdesktop2.desktop
echo 'Comment='$dcomment >> $gdesktop2.desktop
echo 'Categories='$dcategories >> $gdesktop2.desktop
echo 'StartupNotify=true' >> $gdesktop2.desktop
echo 'Icon='$PWD'/ico2.png' >> $gdesktop2.desktop
echo 'Version='$dversion >> $gdesktop2.desktop
chmod a+x $gdesktop.desktop

# winecfg .desktop file
echo '[Desktop Entry]' > winecfg.desktop
echo 'Name=Настройка WINE' >> winecfg.desktop
echo 'Exec=sh '\"''$PWD'/wine/winecfg.sh'\" >> winecfg.desktop
echo 'Type=Application' >> winecfg.desktop
echo 'StartupNotify=true' >> winecfg.desktop
echo 'Icon='$PWD'/wine/winecfg.png' >> winecfg.desktop
echo 'Version='$wversion >> winecfg.desktop
chmod a+x winecfg.desktop

# winetricks .desktop file
echo '[Desktop Entry]' > winetricks.desktop
echo 'Name=winetriks' >> winetricks.desktop
echo 'Exec=sh '\"''$PWD'/wine/winetricks.sh'\" >> winetricks.desktop
echo 'Type=Application' >> winetricks.desktop
echo 'StartupNotify=true' >> winetricks.desktop
echo 'Icon='$PWD'/wine/winecfg.png' >> winetricks.desktop
echo 'Version='$wversion >> winetricks.desktop
chmod a+x winetricks.desktop

# createico .desktop file
echo '[Desktop Entry]' > createicon.desktop
echo 'Name=Создать ярлыки' >> createicon.desktop
echo 'Exec=sh "$PWD""/createicon.sh"' >> createicon.desktop
echo 'Type=Application' >> createicon.desktop
echo 'StartupNotify=true' >> createicon.desktop
echo 'Icon='$PWD'/wine/desktop.png' >> createicon.desktop

if (test -e /usr/bin/zenity);\
	then

	lnk="$(zenity --list --checklist --hide-column=2 --title "Создание ярлыка" --text "Скопировать ярлык" --separator="" --column="y/n" --column "№" --column "Местоположение" --checklist true 1 "в домашний каталог" --checklist true 2 "на рабочий стол" --checklist true 3 "в основное меню")""0"
	if [ $lnk = 0 ] 
		then exit
	fi

	cih="$(ln -s -f -v "$PWD/$gdesktop".desktop /home/"$USER"/"$gdesktop".desktop)"
	cih2="$(ln -s -f -v "$PWD/$gdesktop2".desktop /home/"$USER"/"$gdesktop2".desktop)"

	cid="$(ln -s -f -v "$PWD/$gdesktop".desktop /home/"$USER"/Desktop/"$gdesktop".desktop ; ln -s -f -v "$PWD/$gdesktop".desktop /home/"$USER"/Рабочий\ стол/"$gdesktop".desktop)"
	cid2="$(ln -s -f -v "$PWD/$gdesktop2".desktop /home/"$USER"/Desktop/"$gdesktop2".desktop ; ln -s -f -v "$PWD/$gdesktop2".desktop /home/"$USER"/Рабочий\ стол/"$gdesktop2".desktop)"

	cim="$(gksu ln -s -f "$gdesktop".desktop /usr/share/applications/"$gdesktop".desktop)"
	cim2="$(gksu ln -s -f "$gdesktop2".desktop /usr/share/applications/"$gdesktop2".desktop)"

	case $lnk in
		10 ) $cih; exit 1;; 
		20 ) $cid; exit 1;;
		30 ) $cim; exit 1;;
		120 ) $cih ; $cid; exit 1;; 
		130 ) $cih ; $cim; exit 1;;  
		230 ) $cid ; $cim ; exit 1;; 
		1230 ) $cih ; $cid ; $cim; exit 1;; 
	esac

else
	gxmess="Куда полоджить ярлык?"
	gxmess2=""
	zpt=""
	while [ $lnk!=0 ] 
	do
	gxmessage -title "Создание ярлыка?" -center -buttons "Домашний каталог:3,На рабочий стол:2,В главное меню:1,Выход:0" $gxmess $gxmess2;
	lnk=$?;
		case "$lnk" in
			0 ) exit 1;;
			1 ) gksu 'ln -s -f -v "$gdesktop".desktop /usr/share/applications/"$gdesktop".desktop'; gxmess3+=$zpt" в главном меню"; gxmess=" Ярлык создан $gxmess3. Создать ещё?";zpt=",";;
			2 ) ln -s -f -v "$PWD/$gdesktop".desktop /home/"$USER"/Desktop/"$gdesktop".desktop ; ln -s -f -v "$PWD/$gdesktop".desktop /home/"$USER"/Рабочий\ стол/"$gdesktop".desktop; gxmess3+=$zpt" на рабочем столе"; gxmess="Ярлык создан $gxmess3. Создать ещё?";zpt=",";;
			3 ) ln -s -f -v "$PWD/$gdesktop".desktop /home/"$USER"/"$gdesktop".desktop;gxmess3+=$zpt" в домашнем каталоге"; gxmess="Ярлык создан в $gxmess3. Создать ещё?";zpt=",";;
		esac
	done
fi

