If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
	Write-Warning 'You do not have Administrator rights to run this script! Please re-run this script as an Administrator!'
	Break
} else {

	Write-Host "Downloading VirtualBox, VirtualBox Extensions, and Vagrant"

	If (Test-Path "C:\Program Files\Oracle\VirtualBox\") {
		Write-Host "VirtualBox already installed. Skipping. "
	} else {
		Write-Host "Installing VirtualBox, return to this window once it installs..."
		curl http://download.virtualbox.org/virtualbox/5.0.20/VirtualBox-5.0.20-106931-Win.exe -O "$env:Appdata\vbox.exe"
		& "$env:Appdata\vbox.exe"
		Write-Host "Press any key to continue when Virtualbox is installed..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	}

	If (Test-Path "C:\HashiCorp\Vagrant\bin") {
		Write-Host "Vagrant is already installed. Skipping."
	} else {
		Write-Host "Installing Vagrant, return to this window once it installs..."
		curl https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1.msi -O "$env:Appdata\vagrant.msi"
		msiexec /i "$env:Appdata\vagrant.msi"
		Write-Host "Press any key to continue when Vagrant is installed..."
		$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	}

	If (Test-Path "C:\Program Files\Oracle\VirtualBox\ExtensionPacks\Oracle_VM_VirtualBox_Extension_Pack") {
		Write-Host "VirtualBox Extensions already present. Skipping."
	} else {
		Write-Host "Installing VirtualBox extensions"
		curl http://download.virtualbox.org/virtualbox/5.0.20/Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack -O $env:Appdata\Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack
		& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" extpack install $env:Appdata\Oracle_VM_VirtualBox_Extension_Pack-5.0.20-106931.vbox-extpack
	}

	If (Test-Path "~\fcc-python-vagrant") {
		Write-Host "Repository Exists. Updating repo."
		cd ~\fcc-python-vagrant
		git pull
		& "C:\HashiCorp\Vagrant\bin\Vagrant.exe" up 
	} else {
		Write-Host "Cloning the Git repository"
		git clone https://github.com/byteknacker/fcc-python-vagrant.git ~\fcc-python-vagrant
		cd ~\fcc-python-vagrant
		Write-Host "Creating virtual machine"
		& "C:\HashiCorp\Vagrant\bin\Vagrant.exe" up 
	}

	Write-Host "To start the VM, simply run vagrant ssh."
}
