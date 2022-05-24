#!/bin/bash

#software for Developers
developers(){
    # Collection of packages to install
    PACKAGES=(
        git
        maven
        spring-boot
    )
    # Same packages, but a Seperate list for uninstall packages, as the order may need to be different
    PACKAGES_UNINSTALL=(
        git
        maven
        spring-boot
    )
    echo "$MODE-ing packages..."
    doBrewPackageInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup

    #now install casks
    CASKS=(
        docker
        microsoft-teams
        google-chrome
        parallels
    )
    # Same Casks, but a Seperate list for uninstall casks, as the order may need to be different
    CASKS_UNINSTALL=(
        docker
        microsoft-teams
        google-chrome
    )
    echo "$MODE-ing cask apps..."
    doBrewCaskInstallOrUninstall;
    echo "Cleaning up..."
    brew cleanup

    #if the mode is to uninstall, ensure that the uninstall of parallels is done, as a special case.
    if [ "$MODE" = "uninstall" ]
    then
        parallels_uninstall
    else
        echo "Finished the install"
    fi
}

#parallels uninstall special case
parallels_uninstall(){

        echo "Uninstalling parallels now...."        
        brew uninstall --cask --force parallels
        echo "Cleaning up..."
        brew cleanup


cat << "EOF2"
The uninstall has now finished.....
**** Steps to complete Post uninstall of parallels ****
Please read the below...
The uninstall of parallels should have completed. However, due to an anomoly with the way that parallels installs
, the uninstall may or may not have reported an error. Please follow the instructions below carefully..
you may have seen something like this at the end of the parallels uninstall...
--------------------------------------------------------------------------
Cleaning up...
Error: Permission denied @ apply2files - /usr/local/share/man/man8/prl_convert.8
Steps to carry out to resolve any errors...
------------------------------------------
1. Try and check the health of brew. Try to install something that you havent already got, and see if brew complains. eg. try and install jq.
   >brew install jq (if you already have jq installed, please do a brew uninstall jq followed by the install)
2. If you dont see any errors, then you can exit now, as parallels would have uninstalled without causing any problems.
3. However, if you did see an error, then brew tells you how to rectify this.
4. Follow the instructions given by brew, if it is only changing the owner of the /usr/local/share/man/man8 directory, as this is fairly harmless thing to do.
5. If it is merely changing the owner, please indeed follow the suggested solution by brew.
6. If it is more complex, then please seek help from the authors of this script.
EOF2
}

doBrewPackageInstallOrUninstall(){
    #Note: This function uses the following global variables to have been set before its call
    # MODE               : install or uninstall
    # PACKAGES           : The list of packages that are going to be installed (if this is an install)
    # PACKAGES_UNINSTALL : The list of packages that are going to be installed (if this is an install)
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
    # CASKS_UNINSTALL    : The list of casks that are going to be installed (if this is an install)
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
            echo "you chose to install tools for $opt - $REPLY"
            MODE=install
            install_homebrew
            developers
            break
            ;;
        "*UNINSTALL Developer Tools")
            echo "you chose to Uninstall tools for $opt - $REPLY"
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
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done