#!/bin/sh
show_menu(){

    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 0)${MENU} Restart Apache2 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Mettre à jours update & upgrade ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Installation des paquets ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Création Base De Données${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Installation de Wordpress étape 1 (Cli)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Installation de Wordpress étape 2 (Droit fichier)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Installation de Wordpress étape 3 (Téléchargement du core)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Installation de Wordpress étape 4 (Création de la base de données de Wordpress)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} Installation de Wordpress étape 5 (Vous êtes arrivée a la fin !)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9)${MENU} Recherche des plugins ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10)${MENU} Installation des plugins ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11)${MENU} activation des plugins ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 12)${MENU} desactiver des plugins ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 13)${MENU} suppréssion des plugins ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 14)${MENU} liste des plugins ${NORMAL}"
    echo -e "${MENU}*********************Plus d'options************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 15)${MENU} Installation Vagrant ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 16)${MENU} Vérification Vagrant & VirtualBox ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Tapez exit pour quittez le programme${NORMAL}"
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

clear;
show_menu;
while [ opt != '' ]
  do
        case $opt in

        0) clear;
        option_picked "Redemarer apache2";
        sudo service apache2 restart;  option_picked "Apache2 a redemarer"; show_menu;
        menu;
            ;;

        1) clear;
            option_picked "sudo apt-get update && sudo apt-get upgrade";
            sudo apt-get update && sudo apt-get upgrade; option_picked "Système mit à jour"; show_menu;
            menu;
          ;;

        2) clear;
            option_picked "libapache2-mod-php7.0 est en cours d'installation ...";
        sudo apt-get install libapache2-mod-php7.0 mysql-server php7.0-mysql php7.0 apache2 -y; option_picked "libapache2-mod-php7.0 est installer"; show_menu;
        menu;
            ;;

        3) clear;
            option_picked "La base de données est en cours de création ...";
        sudo mysql -uroot -p; option_picked "L'user est root et le mot de passe est celui que vous avez choisi"; show_menu;
        menu;
            ;;

        4) clear;
            option_picked "Prémiere étape de l'installation de Wordpress";
        sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; option_picked "La prémiere étape est terminé"; show_menu;
        menu;
            ;;


        5) clear;
            option_picked "Seconde étape de l'installation de Wordpress";
        sudo chmod 777 wp-cli.phar; sudo mv wp-cli.phar /usr/local/bin/wp; option_picked "La Seconde étape est terminé"; show_menu;
        menu;
            ;;

        6) clear;
            option_picked "troisième étape de l'installation de Wordpress";
        sudo wp core download --allow-root; option_picked "La troisième étape est terminé, l'installation de WordPress est terminé"; show_menu;
        menu;
            ;;

        7) clear;
            option_picked "Quatriéme étape de l'installation de Wordpress";
            echo "entrée le nom de votre base de donnée"
            read -e dbname break;
            echo "entrée le nom de l'utilisateur"
            read -e user break;
            echo "entrée le mot de passe"
            read -e password break;
        sudo wp config create --dbname=$dbname --dbuser=$user --dbpass=$password --allow-root; option_picked "La quatrième étape est terminé, l'installation de WordPress est terminé"; show_menu;
        menu;
            ;;
            8) clear;
                option_picked "derniere étape de l'installation de Wordpress";
                echo "entrée votre URL"
                read -e urlname break;
                echo "entrée le titre de votre site"
                read -e Titre break;
                echo "entrer votre pseudo"
                read -e admin break;
                echo "entrer votre mot de passe"
                read -e password break;
                echo "entrer votre email"
                read -e email break;
                sudo wp core install --url=$urlname --title=$titre --admin_user=$admin --admin_password=$password --admin_email=$email --allow-root; option_picked "La derniere étape est terminé, l'installation de WordPress est terminé";
                sudo  sudo wp plugin install duplicator wordfence --allow-root; show_menu;
                menu;
                ;;
            9) clear;
               option_picked "Recherche";
               echo "entrée le nom de votre plugin"
               read -e search break;
               sudo wp plugin search $search --allow-root; option_picked "Selectionner un plugin"; show_menu;
               menu;
              ;;
            10)
                option_picked "Installation de plugin";
                echo "entrée le nom de votre plugin"
                read -e install break;
                sudo wp plugin install $install --allow-root; option_picked "Installation terminé"; show_menu;
                menu;
              ;;
            11) clear;
                option_picked "activer un plugin";
                echo "entrée le nom de votre plugin"
                read -e active break;
                sudo wp plugin activate $active --allow-root; option_picked "Activation effectuer"; show_menu;
                menu;
              ;;
            12) clear;
                option_picked "desactiver un plugin";
                echo "entrée le nom de votre plugin"
                read -e desac break;
                sudo wp plugin deactivate $dasac --allow-root; option_picked "desactivation effectuer"; show_menu;
                menu;
              ;;

            13) clear;
                option_picked "suppréssion d'un plugin";
                echo "entrée le nom de votre plugin"
                read -e supp break;
                sudo wp plugin delete $supp --allow-root; option_picked "suppréssion effectuer"; show_menu;
                menu;
              ;;
            14) clear;
                option_picked "liste des plugins";
                sudo wp plugin list --allow-root; option_picked "liste de vos plugins"; show_menu;
                menu;
              ;;

            15) clear;
               my_dir="$(dirname "$0")"
               sudo bash "$my_dir/script.sh"
              ;;
            16) clear;
                my_dir="$(dirname "$0")"
                sudo bash "$my_dir/verif.sh"
              ;;
        exit)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Tapez le numéro d'une options du menu";
        show_menu;
        ;;
    esac
done
