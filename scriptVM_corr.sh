#!bin/sh

# //////// Virtualisation /////////
# TP 1.0
#
# Vous allez devoir faire la réalisation d'un script en BASH qui devra permettre plusieurs choses au lancement, comme :
#
# Permettre la création d'un Vagrantfile qui devra être configurable. Vous devrez, au lancement du script, demander à votre utilisateur s'il veut modifier le nom de son dossier synchronisé. S'il tape "oui", vous devrez lui demander le nom du dossier synchronisé local. S'il tape "non", vous devrez lui créer un dossier "data" par défaut. Une fois que l'utilisateur a tapé le nouveau nom du dossier synchronisé local, vous lui créerez un dossier de ce même nom, et mettrez ce nom dans le Vagrantfile.
#
# Petit plus : permettre à l'utilisateur d'installer une box parmis deux :
# - unbuntu/xenial64
# - ubuntu/trusty64
#
# Petit plus (2) : Ajoutez de la couleur :)
#
# Version 2.0 :
# Permettre, au lancement du script, d'installer automatiquement A.M.P


echo -e "\e[92m Bienvenue sur mon script !\e[0m "


echo "Vagrant.configure("\"2"\") do |config|" > Vagrantfile

# Personnalisation du nom de la box
echo "Merci de choisir parmis ces deux boxes :
     1) ubuntu/trusty64
     2) ubuntu/xenial64
    "
read boxChoice
case $boxChoice in
    1)
        echo "Box trusty choisie."
        echo "config.vm.box = "\"ubuntu/trusty64"\"" >> Vagrantfile
    ;;
    2)
        echo "Box xenial choisie."
        echo "config.vm.box = "\"ubuntu/xenial64"\"" >> Vagrantfile
    ;;
    *)
        echo "Box par défaut (xenial) chosie."
        echo "config.vm.box = "\"ubuntu/xenial64"\"" >> Vagrantfile
    ;;
esac

echo "Assignation par défaut de l'IP suivante : 192.168.33.10"
echo "config.vm.network "\"private_network"\", ip: "\"192.168.33.10"\"" >> Vagrantfile

# Personnalisation le nom du dossier synchronisé local
read -p "Voulez-vous modifier le nom du dossier synchronisé local ? O/n " choice

if [ $choice == "O" ]
then
    read -p "Merci d'entrer le nouveau nom du dossier : " folderName
    mkdir $folderName
    echo "config.vm.synced_folder "\"./$folderName"\", "\"/var/www/html"\"" >> Vagrantfile
else
    echo "Très bien. Le nom du dossier par défaut sera donc 'data.'"
    mkdir data
    echo "config.vm.synced_folder "\"./data"\", "\"/var/www/html"\"" >> Vagrantfile
fi

echo "end" >> Vagrantfile

# Lancement de la vagrant
vagrant up
