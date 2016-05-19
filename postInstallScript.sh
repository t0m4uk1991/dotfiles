#!/bin/bash

echo "Welcome to my post install script"

#install section
function installCommonTools {
	echo "Installing: git 
					  dnsutils 
					  gtypist 
					  vim 
					  moc-ffmpeg-plugin 
					  nmap 
					  keepassx
					  ranger"
	#sudo apt-get install update
	#sudo apt-get install -y git dnsutils gtypist vim moc-ffmpeg-plugin mocp macchanger ascp calibre nmap netcat tcpdump keepassx ranger
}

function addChromeRepo {
	echo "adding Chrome repo to source.list"
	#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	#sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
}

function installChrome {
	echo "installing Google Chrome..."
	#addChromeRepo
	#sudo apt-get update 
	#sudo apt-get install google-chrome-stable
}

function installSkype {
	echo "installing Skype ..."
	#TBD
}

function downloadAndInstallRvm {
	echo "installing rvm ... this can take few minutes"
	#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	#curl -sSL https://get.rvm.io | bash
	#source /home/atom/.rvm/scripts/rvm
}

function installJava {
	echo "please go to \nhttp://www.oracle.com/technetwork/java/javase/downloads/index.html\n and download latest JDK to this script directory"
	echo "Please enter downloaded archive name"
	#read fileName
	#tar -xvf fileName
	#sudo mkdir -p /usr/lib/jvm
	#sudo mv ./jdk1.8.0 /usr/lib/jvm/
	#sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0/bin/java" 1
	#sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0/bin/javac" 1
	#sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0/bin/javaws" 1
	#sudo chmod a+x /usr/bin/java
	#sudo chmod a+x /usr/bin/javac
	#sudo chmod a+x /usr/bin/javaws
	#sudo chown -R root:root /usr/lib/jvm/jdk1.8.0
	#sudo update-alternatives --config java
	#sudo update-alternatives --config javac
	#sudo update-alternatives --config javaws
}

#setup section
function setUpTimeZone {
	echo "Choose you current location and follow the instructions"
	echo "Press any key to continue"
	read nop 
	#sudo dpkg-reconfigure tzdata
}

function setUpKeyboardLayout {
	echo "update properties in /etc/default/keyboard and ~/.config/openbox/autostart"
	#sudo su
	#echo "# KEYBOARD CONFIGURATION FILE
	## Consult the keyboard(5) manual page.
	#XKBMODEL=\"pc105\"
	#XKBLAYOUT=\"us,ua\"
	#XKBVARIANT=""
	#XKBOPTIONS=\"grp:alt_shift_toggle\"
	#BACKSPACE=\"guess\"" > /etc/default/keyboard
	#exit
	
	#echo "fbxkb &" >> ~/.config/openbox/autostart
	
}



function makeDecision {
	while true; do
		read -p "Do you wish to execute $1?[Y/n]" yn
		case $yn in
			[Yy]* ) $1;break;;
			[Nn]* ) break;;
			* ) echo "Please answer yes or no.";;
		esac
	done
}

function runPostInstallScript {
	actions=("installCommonTools" "installChrome" "installSkype"  "downloadAndInstallRvm" "installJava" "setUpTimeZone" "installJava")
		for action in ${!actions[*]}
		do
			makeDecision "${actions[$action]}"
		done
}

makeDecision runPostInstallScript
