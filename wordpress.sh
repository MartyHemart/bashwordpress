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
    echo -e "${MENU}**${NUMBER} 1)${MENU} PHP 7.0 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Apache2 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} PHP 7.0 MY SQL ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} libapache2-mod-php7.0 ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Création Base De Données${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Installation de Wordpress étape 1 (Cli)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Installation de Wordpress étape 2 (Droit fichier)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} Installation de Wordpress étape 3 (Téléchargement du core)${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9)${MENU} Installation de Wordpress étape 4 (Création de la base de données de Wordpress)${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in

        0) clear;
        option_picked "Redemarer apache2";
        sudo service apache2 restart;  option_picked "Apache2 a redemarer"; show_menu; break; 
        menu;
            ;;
        1) clear;
        option_picked "PHP 7 est en cours d'installation ...";
        sudo apt-get install php7.0; option_picked "PHP 7 est installer"; show_menu;  break; 
        menu;
        
        ;;

        2) clear;
            option_picked "Apache 2 est en cours d'installation ...";
            sudo apt-get install apache2;  option_picked "Apache2 est installer"; show_menu; break; 
        menu;
            ;;

        3) clear;
            option_picked "PHP 7 MY SQL est en cours d'installation ...";
        sudo apt-get install php7.0-mysql; option_picked "PHP 7 MY SQL est installer"; show_menu;  break; 
        menu;
            ;;

        4) clear;
            option_picked "libapache2-mod-php7.0 est en cours d'installation ...";
        sudo apt-get install libapache2-mod-php7.0; option_picked "libapache2-mod-php7.0 est installer"; show_menu;  break; 
        menu;
            ;;
        
        5) clear;
            option_picked "La base de données est en cours de création ...";
        sudo mysql -uroot -p; option_picked "L'user est root et le mot de passe est celui que vous avez choisi"; show_menu;  break; 
        menu;
            ;;

        6) clear;
            option_picked "Prémiere étape de l'installation de Wordpress";
        sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; option_picked "La prémiere étape est terminé"; show_menu;  break; 
        menu;
            ;;

        
        7) clear;
            option_picked "Seconde étape de l'installation de Wordpress";
        sudo chmod 777 wp-cli.phar; sudo mv wp-cli.phar /usr/local/bin/wp; option_picked "La Seconde étape est terminé"; show_menu;  break; 
        menu;
            ;;

        8) clear;
            option_picked "troisième étape de l'installation de Wordpress";
        sudo wp core download --allow-root; option_picked "La troisième étape est terminé, l'installation de WordPress est terminé"; show_menu;  break; 
        menu;
            ;;

        9) clear;
            option_picked "Quatriéme étape de l'installation de Wordpress";
            echo "entrée le nom de votre base de donnée"
            read -e dbname break;
            echo "entrée le nom de l'utilisateur"
            read -e user break;
            echo "entrée le mot de passe"
            read -e password break;
        sudo wp config create --dbname=$dbname --dbuser=$user --dbpass=$password --allow-root; option_picked "La quatrième étape est terminé, l'installation de WordPress est terminé"; show_menu;  break; 
        menu;
            ;;   
        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done

