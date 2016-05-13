If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
    Write-Warning “You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!”
    Break
} else {

    Write-Host "Downloading VirtualBox, VirtualBox Extensions, and Vagrant"


curl http://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Win.exe -O C:\vbox.exe
curl http://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack -O C:\Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack
curl https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1.msi -O C:\vagrant.msi

Write-Host "Installing VirtualBox, return to this window once it installs..."

& C:\vbox.exe 

Write-Host "Press any key to continue when Virtualbox is installed..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


Write-Host "Installing Vagrant, return to this window once it installs..."

msiexec /i C:\vagrant.msi 

Write-Host "Press any key to continue when Vagrant is installed..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Write-Host "Installing VirtualBox extensions"

& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" extpack install C:\Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack


Write-Host "Cloning the Git repository"
git clone https://github.com/byteknacker/fcc-python-vagrant.git C:\fcc-python-vagrant

cd C:\fcc-python-vagrant

Write-Host "Creating virtual machine"
& "C:\HashiCorp\Vagrant\bin\Vagrant.exe" up 
Write-Host "Press any key to continue when Vagrant finishes building..."

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")




Write-Host "To start the VM, simply run vagrant ssh."




}