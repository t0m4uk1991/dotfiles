#!/bin/bash -ex

echo "Welcome to my post install script"

#install section
function installCommonTools {
	echo "Installing: git                (vcs)
					  dnsutils           (set of network tools) 
					  gtypist            (keyboard simulator)
					  vim                (editor)
					  moc-ffmpeg-plugin  (console player) 
					  macchanger         (tool for changing MAC)
					  calibre            (ebook manager)
					  ranger             (consolo file manager)
                      nmap               (portscanner)
                      keepassx           (password manager)
                      gitk               (git ui tool)"
	sudo apt-get install -y git dnsutils gtypist vim moc-ffmpeg-plugin macchanger calibre nmap keepassx ranger gitk net-tools
}

function downloadAndInstallRvm {
	echo "installing rvm ... this can take few minutes"
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | bash
	source /home/atom/.rvm/scripts/rvm
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
	
	sudo sh -c 'echo "# KEYBOARD CONFIGURATION FILE
	## Consult the keyboard(5) manual page.
	#XKBMODEL=\"pc105\"
	#XKBLAYOUT=\"us,ua\"
	#XKBVARIANT=""
	#XKBOPTIONS=\"grp:alt_shift_toggle\"
	#BACKSPACE=\"guess\"" > /etc/default/keyboard'
	
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
	actions=("installCommonTools" "downloadAndInstallRvm" "installJava" "setUpTimeZone" "setUpKeyboardLayout")
		for action in ${!actions[*]}
		do
			makeDecision "${actions[$action]}"
		done
}

makeDecision runPostInstallScript
