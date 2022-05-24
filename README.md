# macbook-software
 
### A bash script to install tools used by Developers
 
Click the Launchpad (Rocket icon) and search for Terminal. Open a terminal – The Mac terminal seems to be almost identical to a Linux Bash Shell. Like using WSL on Windows.
 
Enter the following into the terminal:
 
- Create folder called Projects % `mkdir macbook-software`
- Navigate to the new folder % `copy the setup.sh script to the folder`
- Navigate to the macbook-software folder % `cd macbook-software`
- Make it executable % `chmod +x setup.sh`
- Run the script % `./setup.sh`
 
As the script runs it will prompt several times for admin password to proceed with an install. The admin password is the one you use to login to the Macbook, not your AppleId password.

You can also use the simple following one-liner in the terminal to run the script without needing to download, set permissions etc.
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/...setup.sh)"`
 
### The software to be installed is:
 
**For Developers:**
- brew
- git
- maven
- spring-boot
- docker
- microsoft-teams
- google-chrome

