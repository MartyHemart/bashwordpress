#!/bin/bash
echo "#########################################################"
echo -e "#################\e[32mBienvenue dans le menu\e[0m##################"
echo "#########################################################"
echo -e "\e[32mMerci de choisir un version de Linux :\e[0m"
echo " 1: ubuntu/xenial64"
echo " 2: ubuntu2"
echo " 3: quitter le programme, taper exit"
#options=("ubuntu1" "ubuntu2" "Quit")
ubuntu=""
read opt #deux choix disponible, je vous conseil le premier ;)
    case $opt in
        "1") ubuntu="ubuntu\/xenial64"
        ;;
        "2") ubuntu="ubuntu2"
        ;;
        "3")
        echo -e "\e[31mFermeture du programme !\e[0m"
        exit  #Quitte le programe si l'utilisateur tape exit
        ;;
        *) echo -e "\e[31m\e[1mMerci de selectionner un système correct et de relancer le programme\e[0m"
           exit # Quitte le programme si l'utilisateur se trompe d'options !!!
    esac

if [[ "$ubuntu"=="ubuntu\/xenial64" ]]; then  #Selectionne ubuntu/xenial64 si réponse est 1
  echo -e " \e[32m\e[5mVous avez selectionner $ubuntu\e[25m\e[0m "

elif [[ "$ubuntu"=="ubuntu2" ]]; then  #Selectionne ubuntu2 si réponse est 1
  echo "Bravo vous avez la $ubuntu"
fi

echo "indiquer votre dossier de synchro local"  #Indiquer le dossier de synchro en local
read synlocal

echo "indiquer votre dossier de synchro distant"   #Indiquer le dossier de synchro en distant
read syndistant

echo "vous avez selectionner la version $ubuntu qui sera en local sur $synlocal et en distant sur $syndistant"  #recape de tous les élèments choisie

echo -e "\e[42m\e[1mTaper OK ou NO pour continuer\e[27m\e[0m: "
read ok
     if [ "$ok" = "ok" ] || [ "$ok" = "OK" ]; then  #l'utilisateur indique si il veux vraiment installer une vagrant en indiquant ok ou OK si la réponse es non alors le programme se ferme
        echo -e "\e[92m\e[5m$ok l'installation de Vagrant va démarrer !!\e[25m" #Lancement de l'installation
        vagrant init #Initaliste Vagrantfile
        sed -i -e 's/base/'$ubuntu'/' Vagrantfile #|| echo "Attention, erreur detecter !!"#Modification du fichier "Vagrantfile" avec affichage de l'erreur au cas ou !
        sed -i -e 's/# config.vm.network "private_network", ip: "192.168.33.10"/config.vm.network "private_network", ip: "192.168.33.10"'/ Vagrantfile #|| echo "Attention, erreur detecter !!"#Modification du fichier "Vagrantfile" avec affichage de l'erreur au cas ou !
        sed -i -e 's/# config.vm.synced_folder "..\/data", "\/vagrant_data"/config.vm.synced_folder ".\/data", "\/var\/www\/html"'/ Vagrantfile #|| echo "Attention, erreur detecter !!"#Modification du fichier "Vagrantfile" avec affichage de l'erreur au cas ou !
        mkdir data   #Création du dossier data
        vagrant up   #Lancement de la vagrant
        #vagrant ssh  #Connexion SSH a la vagrant
   elif [ "$ok" = "no" ] || [ "$ok" = "NO" ]; then #Si il indique no ou NO le programme ferme.
        echo "merci à vous ! A bientôt"
   else
        echo "Vous n'avez rien choisie, bye."
   fi

   echo -e "\e[42m\e[1mVoulez-vous voir les vagrant en cours d'utilisation ?\e[27m\e[0m: "
   read ouinon
        if [ "$ouinon" = "oui" ] || [ "$ouinon" = "OUI" ]; then  #l'utilisateur indique si il veux voir les vagrant actif
        echo -e "Actuellement, voici les vagrant en cours d'utilisation : "
        vagrant global-status
      elif [ "$ouinon" = "non" ] || [ "$ouinon" = "NON" ]; then #Si il indique non ou NON le programme ferme.
           echo "merci à vous ! A bientôt"
      else
           echo "Vous n'avez rien choisie, bye."
      fi
      # On demande à l'utilisateur de choisir la machine à utiliser
 while true ; do
  optionsVagrant=("Eteindre une vagrant" "Eteindre toutes les vagrant")
  sleep 1
  echo -e "Que voulez vous faire ?"
  select responseVagrant in "${optionsVagrant[@]}";do
      case ${responseVagrant} in
          "Eteindre une vagrant" ) actionVagrant="shutDown";break;;
          "Eteindre toutes les vagrant" ) actionVagrant="shutDownAll";break;;
      esac
  done
# Eteindre une vagrant en marche
  if [ "$actionVagrant" == "shutDown" ]
      then
      sleep 1
      echo -e "Quelle machine voulez vous éteindre ? (ID)"
      read -p idDown
              sleep 1
      vagrant halt $idDown
      echo -e "La vagrant $idDown a bien été éteinte"
      sleep 1
  fi
 done
      
