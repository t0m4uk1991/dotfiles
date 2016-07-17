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
					  ranger
                      nmap
                      keepasx"
	sudo apt-get install -y git dnsutils gtypist vim moc-ffmpeg-plugin mocp macchanger ascp calibre nmap netcat tcpdump keepassx ranger
}

function addChromeRepo {
	echo "adding Chrome repo to source.list"
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
}

function installChrome {
	echo "installing Google Chrome..."
	addChromeRepo
	sudo apt-get update 
	sudo apt-get install google-chrome-stable
}

function installSkype {
	echo "installing Skype ..."
	#TBD
}

function downloadAndInstallRvm {
	echo "installing rvm ... this can take few minutes"
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | bash
	source /home/atom/.rvm/scripts/rvm
}

function downloadAndInstallMongoDb{
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
    echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    sudo service mongod start
    grep "waiting for connections on port" /var/log/mongodb/mongod.log
}

function installJava {
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u92-b14/jdk-8u92-linux-x64.tar.gz
	tar -xvf jdk-8u92-linux-x64.tar.gz
	sudo mkdir -p /usr/lib/jvm
	sudo mv ./jdk1.8.0_92 /usr/lib/jvm/
	sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_92/bin/java" 1
	sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_92/bin/javac" 1
	sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0_92/bin/javaws" 1
	sudo chmod a+x /usr/bin/java
	sudo chmod a+x /usr/bin/javac
	sudo chmod a+x /usr/bin/javaws
	sudo chown -R root:root /usr/lib/jvm/jdk1.8.0_92
	sudo update-alternatives --config java
	sudo update-alternatives --config javac
	sudo update-alternatives --config javaws
}

function setUpTimeZone {
	echo "Choose you current location and follow the instructions"
	sudo dpkg-reconfigure tzdata
	echo "Press any key to continue"
	read nop 
}

function setUpKeyboardLayout {
	echo "update properties in /etc/default/keyboard and ~/.config/openbox/autostart"
	sudo su
	echo "# KEYBOARD CONFIGURATION FILE
	## Consult the keyboard(5) manual page.
	#XKBMODEL=\"pc105\"
	#XKBLAYOUT=\"us,ua\"
	#XKBVARIANT=""
	#XKBOPTIONS=\"grp:alt_shift_toggle\"
	#BACKSPACE=\"guess\"" > /etc/default/keyboard
	exit
	
	echo "fbxkb &" >> ~/.config/openbox/autostart
	
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
	actions=("installCommonTools" "installChrome" "installSkype"  "downloadAndInstallRvm" "installJava" "setUpTimeZone" "setUpKeyboardLayout" "downloadAndInstallMongoDb")
		for action in ${!actions[*]}
		do
			makeDecision "${actions[$action]}"
		done
}

makeDecision runPostInstallScript
