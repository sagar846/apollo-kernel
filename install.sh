#
# Automates kernel Installing using the ARCH Build System
#

pkgbase="linux-apollo"
headers="linux-apollo-headers"
version="4.13.10"

# Check for root access
if [ $EUID -ne 0 ]; then
	echo -e "You don't have admin privilegies, execute the script as root."
	exit 1
fi

echo 'Running makepkg'
makepkg
echo 'done'

echo 'Installing the compiled files'
sudo pacman -U $headers-$version.pkg.tar.xz
sudo pacman -U $pkgbase-$version.pkg.tar.xz

echo 'Done'

echo 'Updating grub'
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo '--------Finished--------'
