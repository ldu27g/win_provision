#############################
# Make directory
#############################
New-Item c:\Ansible_work -itemType Directory
Set-Location c:\Ansible_work

#############################
# Ansible Configure
#############################
# Execute  Ansible Preparation Scripts
Invoke-WebRequest -Uri http://10.122.26.149/root/win-provision-scripts/raw/master/ConfigureRemotingForAnsible.ps1 -OutFile ConfigureRemotingForAnsible.ps1
.\ConfigureRemotingForAnsible.ps1 -SkipNetworkProfileCheck

#############################
# Create Ansible User
#############################
Invoke-WebRequest -Uri http://10.122.26.149/root/win-provision-scripts/raw/master/create_ansible_user.ps1 -OutFile create_ansible_user.ps1
.\create_ansible_user.ps1 -SkipNetworkProfileCheck

