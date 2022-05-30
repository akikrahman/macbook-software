# macbook-software
 
### A bash script to install tools used by Developers
 
Click the Launchpad (Rocket icon) and search for Terminal. Open a terminal – The Mac terminal seems to be almost identical to a Linux Bash Shell. Like using WSL on Windows.
 
Enter the following into the terminal:
 
- Create folder called macbook-software % `mkdir macbook-software`
- Navigate to the macbook-software folder % `cd macbook-software`
- Copy the script to the new folder % `curl -o setup.sh https://github.com/akikrahman/macbook-software/blob/main/setup.sh`
- Make it executable % `chmod +x setup.sh`
- Run the script % `./setup.sh`
 
As the script runs it will prompt several times for admin password to proceed with an install. The admin password is the one you use to login to the Macbook, not your AppleId password.

### The software to be installed is:
 
**For Developers:**
- brew
- git
- maven
- docker
- microsoft-teams
- google-chrome
- visual-studio-code
- intellij-idea-ce
- postman

