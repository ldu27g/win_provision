powershell Set-ExecutionPolicy RemoteSigned

#############################
# Do powershell on DOS
#############################
@(echo '> NUL
echo off)
setlocal enableextensions
set "THIS_PATH=%~f0"
set "PARAM_1=%~1"
PowerShell.exe -Command "iex -Command ((gc \"%THIS_PATH:`=``%\") -join \"`n\")"
exit /b %errorlevel%
') | sv -Name TempVar

##########################################################
##############                      ######################
############## PowerShell Execution ######################
##############                      ######################
##########################################################

#############################
# Make directory
#############################
New-Item c:\Ansible_work -itemType Directory
Set-Location c:\Ansible_work

#############################
# Ignore SSL Error
#############################
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

#############################
# Ansible Configure
#############################
# Execute  Ansible Preparation Scripts
Invoke-WebRequest -Uri https://10.122.26.149/root/win-provision-scripts/raw/master/ConfigureRemotingForAnsible.ps1 -OutFile ConfigureRemotingForAnsible.ps1
.\ConfigureRemotingForAnsible.ps1 -SkipNetworkProfileCheck

#############################
# Create Ansible User
#############################
Invoke-WebRequest -Uri https://10.122.26.149/root/win-provision-scripts/raw/master/create_ansible_user.ps1 -OutFile create_ansible_user.ps1
.\create_ansible_user.ps1 -SkipNetworkProfileCheck


