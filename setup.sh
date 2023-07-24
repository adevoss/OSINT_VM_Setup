#!/bin/bash
# Most of this script is supplied by Michael Bazzel, so credit where credit is due.

# Show desktop
gnome-extensions enable desktop-icons@csoriano

# Google
gpg --keyserver keyserver.ubuntu.com --recv 4EB27DB2A3B88B8B  
gpg --export --armor 4EB27DB2A3B88B8B | sudo apt-key add -

sudo apt-get -y update
sudo apt-get -y upgrade

# Requirements for installing tools

requirements=("python3" "python-setuptools" "jq" "python3-pip" "git" "findutils" "curl" "wget" "unzip")

echo "Installing ..."
for requirement in "${requirements[@]}"; do
    sudo apt-get install -y $requirement
done

#ToDo: Move user.js file to proper directory ~/.mozilla/ http://kb.mozillazine.org/Profile_folder

echo
echo "Download manually (redirected to Proton): https://inteltechniques.com/osintbook/vm-files.zip to ~/Desktop"
echo "Press key... (Ctrl-c to exit)"
echo
read -n 1 -s

#Install scripts and launchers
cd ~/Desktop
unzip vm-files.zip -d /home/osint/Desktop/
mkdir ~/Documents/scripts
mkdir ~/Documents/icons
cd ~/Desktop/vm-files/scripts
sudo cp -r * ~/Documents/scripts
cd ~/Desktop/vm-files/icons
cp -r * ~/Documents/icons
cd ~/Desktop/vm-files/shortcuts
sudo cp -r * /usr/share/applications/
cd ~/Downloads
mkdir Programs
cd Programs

# Tools
# media tools
sudo snap install vlc
sudo -H pip3 install --upgrade youtube_dl
sudo apt-get install -y ffmpeg
sudo -H pip3 install Instalooter
sudo -H pip3 install Instaloader

# Twint
git clone https://github.com/twintproject/twint.git
cd twint
sudo -H pip3 install twint
sudo -H pip3 install -r requirements.txt
cd ~/Downloads/Programs

# EyeWitness
git clone https://github.com/ChrisTruncer/EyeWitness.git
cd EyeWitness/Python/setup
sudo -H ./setup.sh
cd ~/Documents/scripts
sed -i "s/Programs\/EyeWitness/Programs\/EyeWitness\/Python/g" eyewitness.sh
cd ~/Downloads/Programs

# Amass
sudo snap install amass

# sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r && sudo -H pip3 install -r requirements.txt
cd ~/Downloads/Programs

#Photon
git clone https://github.com/s0md3v/Photon.git
cd Photon && sudo -H pip3 install -r requirements.txt
cd ~/Downloads/Programs

# The Harvester
git clone https://github.com/laramies/theHarvester.git
cd theHarvester 
git checkout 8b88a66
sudo -H pip3 install -r requirements.txt
cd ~/Downloads/Programs

# Other assorted tools
sudo python3 -m pip install pipenv
sudo apt-get install -y mediainfo-gui
sudo apt install -y libimage-exiftool-perl
sudo apt-get install -y webhttrack
sudo wget -O google-earth64.deb http://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
sudo dpkg -i google-earth64.deb
sudo apt-get -f install; sudo rm google-earth64.deb
sudo snap install keepassxc
sudo apt install -y kazam

# Modify scripts
cd ~/Documents/scripts/
sed -i "s/python3\.6/python3/g" domains.sh
sed -i "s/python\ sublist3r/python3\ sublist3r/g" domains.sh
sed -i "s/pip\ install/pip3\ install/g" updates.sh
sed -i "s/sudo\ pip3/sudo\ \-H\ pip3/g" updates.sh
pip3 install --upgrade pip
cd ~/Downloads/Programs

# Metagoofil
git clone https://github.com/opsdisk/metagoofil.git
cd metagoofil
sudo -H pip3 install -r requirements.txt
cd ~/Downloads/Programs

# Recon-NG (Install your api keys to get full functionality)
git clone https://github.com/lanmaster53/recon-ng.git
cd recon-ng
sudo -H pip3 install -r REQUIREMENTS
cd ~/Downloads/Programs

# Sherlock
git clone https://github.com/sherlock-project/sherlock.git
cd sherlock
python3 -m pip install -r requirements.txt
cd ~/Documents/scripts/
sed -i 's/Programs\/sherlock/Programs\/sherlock\/sherlock/g' sherlock.sh
cd ~/Downloads/Programs

# Spiderfoot (Install your api keys to get full functionality)
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
sudo -H pip3 install -r requirements.txt
cd ~/Documents/scripts
sed -i '/^sudo/ d' spiderfoot.sh
sed -i '/^firefox/ d' spiderfoot.sh
echo "cd ~/Downloads/Programs/spiderfoot" >> spiderfoot.sh
echo "python3 sf.py -l 127.0.0.1:5001 &" >> spiderfoot.sh
echo "sleep 5" >> spiderfoot.sh
echo "firefox http://127.0.0.1:5001" >> spiderfoot.sh
cd ~/Downloads/Programs

# Elasticsearch-Crawler
git clone https://github.com/AmIJesse/Elasticsearch-Crawler.git
cd Elasticsearch-Crawler
sudo -H pip3 install nested-lookup
sudo -H pip3 install internetarchive

#ToDo: VMware tools installation
