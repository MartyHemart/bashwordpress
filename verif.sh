#!/bin/bash
  echo "#########################################################"
  echo -e "##\e[32mBienvenue dans l'installateur de VirtualBox & Vagrant\e[0m##"
  echo "#########################################################"
  echo -e "\e[31mRecherche de Vagrant... \e[0m"
  findPackage=$(dpkg-query -W --showformat='${Status}\n' vagrant|grep "install ok installed") #Recherche du paquet "vagrant"

  if [ "" == "$findPackage" ] #Lancement de l'installation de Vagrant si elle n'est pas installer
  then
    echo "Installation de Vagrant..."
    wget https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_x86_64.deb #Téléchargement du Vagrant
    sudo dpkg -i vagrant_2.1.1_x86_64.deb #Lancement de l'installation
    echo -e "\e[33mVersion de Vagrant :\e[0m"
    vagrant -v; #Affiche la version de la vagrant installer
  else
    echo "Vagrant est déjà installé, voulez-vous le désinstaller pour le réinstaller ? (y/n)"
    read -rsn1 choicePackage #demande si l'utilisateur veux re installer vagrant

    while [ "$choicePackage" != "y" ] && [ "$choicePackage" != "n" ]; do
      echo "Voulez-vous désinstaller Vagrant pour le réinstaller ? (y/n)"
      read -rsn1 choicePackage
    done

    if [ "$choicePackage" == "y" ] #Si l'utilisateur souhaite re installer vagrant
    then
      echo "Désinstallation de Vagrant...";
      sudo apt-get remove --auto-remove vagrant #Suppréssion de Vagrant
      rm -r ~/.vagrant.d; #Suppréssion des dossiers
      echo "Installation de Vagrant...";
      wget https://releases.hashicorp.com/vagrant/2.1.1/vagrant_2.1.1_x86_64.deb #Téléchargement de vagrant
      sudo dpkg -i vagrant_2.1.1_x86_64.deb; #Installation de vagrant
      echo -e "\e[33mVersion de Vagrant :\e[0m"
      vagrant -v; # Affiche la version de Vagrant
    elif [ "$choicePackage" == "n" ] # Si l'utilisateur ne souhaite pas ou a déjà vagrant alors il lui affiche la verison actuel de sa vagrant
      echo -e "\e[33mVersion de Vagrant :\e[0m"
      vagrant -v; #Version de Vagrant
    then
      echo -e "\e[5m\e[34mvous allez passer au programme suivant\e[0m\e[25m"
    fi
  fi

  echo -e "\e[31mRecherche de VirtualBox...\e[0m"
  findPackage=$(dpkg-query -W --showformat='${Status}\n' virtualbox|grep "install ok installed") #recheche sur virtualbox est installer sur l'ordinateur de l'utilisateur

  if [ "" == "$findPackage" ]  # Si virtualbox n'est pas installer alors il l'install
  then
    echo "Installation de VirtualBox..."
    sudo apt-install virtualbox -y || echo "Attention, erreur detecter !!" #Lance une erreur si l'installation echoue
    sudo apt-install virtualbox-qt -y || echo "Attention, erreur detecter !!" #Lance une erreur si l'installation echoue
  else
    echo "VirtualBox est déjà installé, voulez-vous le désinstaller pour le réinstaller ? (y/n)"
    read choicePackage;

    while [ "$choicePackage" != "y" ] && [ "$choicePackage" != "n" ]; do  #demande à l'utilisateur si il souhaite réinstaller virtualbox
      echo "Voulez-vous désinstaller VirtualBox pour le réinstaller ? (y/n)"
      read -rsn1 choicePackage
    done

    if [ "$choicePackage" == "y" ] #SI l'utilisateur souhaite réinstaller virtualbox alors il le supprime
    then
      echo "Désinstallation de VirtualBox..."
      sudo apt-get remove --purge virtualbox #Suppréssion du paquet
      sudo rm ~/"VirtualBox VMs" -Rf #Suppréssion des dossiers
      sudo rm ~/.config/VirtualBox/ -Rf  #Suppréssion des dossiers
      echo "Installation de VirtualBox..." #Installation de virtualbox après la Suppréssion
      sudo apt-install virtualbox -y || echo "Attention, erreur detecter !!" #Installation du paquet virtualbox
      sudo apt-install virtualbox-qt -y || echo "Attention, erreur detecter !!"  #Installation du paquet virtualbox
    elif [ "$choicePackage" == "n" ] #SI l'utilisateur ne souhaite pas installer ou re installer alors le programme ferme
    echo -e "\e[31mLe programme va s'arreter\e[0m"
  then
    exit #Ferme l'application !
    fi
  fi
