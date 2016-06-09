########################################################
# Install packages
###################################################### 

Set-ExecutionPolicy Unrestricted -Scope CurrentUser

$InstallDir=$env:ProgramW6432
$pathValue=$env:Path
$IsChocoEnvPathPresent = Test-Path $env:ChocolateyInstall
$IsVboxExtensionPackPresent=$InstallDir + "\Oracle\VirtualBox\ExtensionPacks\Oracle_VM_VirtualBox_Extension_Pack"
   
if(!( $IsChocoEnvPathPresent))
    {
    Write-Host "Installing Chocolatey"
    powershell -NoProfile -ExecutionPolicy Unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" 
    }
    else
    {

     $chocVersion=choco --version

     if(!($chocVersion -match "0.9.9.12"))
     {
     Write-Host "Updating chocolatey to latest version !"
     choco upgrade chocolatey 

     }
      Write-Host "Chocolatey present  !"
    }
    
 $env:PSModulePath = [System.Environment]::GetEnvironmentVariable("PSModulePath","Machine") #refresh env variables 


Write-Host "Installing latest packages for ....virtual box and extension pack, vagrant and git"

#######################_____VirtualBox____################################ 

$Vbox=.\Get-InstalledSoftware.ps1 -ComputerName $env:COMPUTERNAME | ? {$_.AppName -match “VirtualBox” } -Verbose


if(!($Vbox.AppVersion -ne $null -and $Vbox.AppVersion -match "5.0.20")  )
    {
     choco install virtualbox -version 5.0.20.106931 -y --force  
    }
    else
    {
     Write-Host("Virtual Box Version "+$Vbox.AppVersion +" present, skipping installation ! ")
    } 
       
 if (!($IsVboxExtensionPackPresent )) 
    {
    Write-Host "Installing VirtualBox extensions"
    choco install virtualbox.extensionpack -version 5.0.20.106931 -y 
    }
    else
    { 
    Write-Host "VirtualBox Extensions present, skipping installation !"
    }
   
#########################_____Vagrant____################################# 
   
  $Vagrant=.\Get-InstalledSoftware.ps1 -ComputerName $env:COMPUTERNAME | ? {$_.AppName -match “vagrant” } -Verbose


  if(!($Vagrant.AppVersion -ne $null -and $Vagrant.AppVersion -match "1.8.1") )
    {
     choco install vagrant -version 1.8.1 --force -y  
    }
    else
    {
    Write-Host("Virtual Box Version "+$Vagrant.AppVersion+ "  present, skipping installation ! ")
    }
       
######################____Git____#################################### 

   $gitVersion= .\Get-InstalledSoftware.ps1 -ComputerName $env:COMPUTERNAME | ? {$_.AppName -match “Git version” } -Verbose

   if(!( $gitVersion.AppVersion -ne $null -and $gitVersion -match '2.8.2' ))
    {
    choco install git -version 2.8.2 -y --force
    }
    else
    {
    Write-Host("Git version present "+$gitVersion.AppVersion+" skipping installation ! ")
    }

   $env:PSModulePath = [System.Environment]::GetEnvironmentVariable("PSModulePath","Machine") #refresh env variables 
 
######################################################
# Running vagrant
######################################################

vagrant up

echo("------------------------------------------------------")
echo("Please run 'vagrant ssh' from Git Bash")
echo("-------------------------------------------------------")