#!/bin/bash

#software for Developers
developers(){
    # Collection of packages to install
    PACKAGES=(
        git
        maven
    )
    # Same packages, but a Seperate list for uninstall packages, as the order may need to be different
    PACKAGES_UNINSTALL=(
        maven
        git
    )
    echo "$MODE-ing packages..."
    doBrewPackageInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup

    #now install casks
    CASKS=(
        microsoft-teams
        google-chrome
        visual-studio-code
        intellij-idea-ce
        postman
    )
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        microsoft-teams
        google-chrome
        visual-studio-code
        intellij-idea-ce
        postman
    )
    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup

}


doBrewPackageInstallOrUninstall(){
    #Note: This function uses the following global variables to have been set before its call
    # MODE               : install or uninstall
    # PACKAGES           : The list of packages that are going to be installed (if this is an install)
    # PACKAGES_UNINSTALL : The list of packages that are going to be uninstalled (if this is an uninstall)
    case "$MODE" in
        'install')
                brew install ${PACKAGES[@]}
                ;;
        'uninstall')
                for i in "${PACKAGES_UNINSTALL[@]}"; do
                    echo "uninstalling package $i...."
                    brew uninstall $i
                done
                ;;
            *)
                echo "unexpected error. Exiting...."
                return 1
    esac
}

doBrewCaskInstallOrUninstall(){
    #Note: This function uses the following global variables to have been set before its call
    # MODE               : install or uninstall
    # CASKS              : The list of casks that are going to be installed (if this is an install)
    # CASKS_UNINSTALL    : The list of casks that are going to be uninstalled (if this is an uninstall)
    case "$MODE" in
        'install')
                brew install --cask --force ${CASKS[@]}
                ;;
        'uninstall')
                for i in "${CASKS_UNINSTALL[@]}"; do
                    echo "Uninstalling cask $i....."
                    brew uninstall --cask --force $i
                done
                ;;
            *)
                echo "unexpected error. Exiting...."
                return 1
    esac
}

 # Install homebrew if not already installed
install_homebrew(){
        if test ! $(which brew); then
            echo "Installing homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        fi
        # Update homebrew
        brew update
}

clear
# Bootstrap script for setting up a new OSX machine

echo
echo "Macbook Development Tools Installer"
echo ""
echo ""
ECHO "Pease enter your choice: "
options=("Install Developer Tools"  "*UNINSTALL Developer Tools" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install Developer Tools")
            echo "you chose Option: $opt - $REPLY"
            MODE=install
            install_homebrew
            developers
            break
            ;;
        "*UNINSTALL Developer Tools")
            echo "you chose Option: $opt - $REPLY"
            MODE=uninstall
            #check that folks are sure whether they wish to uninstall....
            echo -n "Answer \"yes\" if you are sure you wish to uninstall..."
            read ANSWER
            if [ "$ANSWER" = "yes" ]
            then
                #even though we are uninstalling we still need to install brew
                install_homebrew
                developers
            else
                echo "Bailing out..."
            fi
            break
            ;;
        "Quit")
            echo "Bailing out..."
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
