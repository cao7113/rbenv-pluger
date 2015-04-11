echo http://ubuntuhandbook.org/index.php/2014/04/install-adobe-flash-in-ubuntu-14-04-lts/

sudo apt-get update
sudo apt-get purge adobe-flash{plugin,-properties-gtk}
sudo apt-get install flashplugin-installer
