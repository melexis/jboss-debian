
# Inline provisioning script
$script = <<SCRIPT

# remove the melexis apt repo from the list
# it bombs out on libperl-error because it can't get
# to the repo over the VPN connection and it is
# locally upgraded for one reason or another.
sed -i.bak '/.*aptmaster.*/d' /etc/apt/sources.list
sed -i.bak '/.*debian.tryphon.eu.*/d' /etc/apt/sources.list

# install essential tools
apt-get update
apt-get -y --force-yes install devscripts build-essential fakeroot debhelper gnupg dh-make

# install build dependencies
cd /vagrant/jboss
yes | mk-build-deps --install debian/control

SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "wheezy"
  config.vm.box_url = "http://hudson2-test.colo.elex.be/wheezy64.box"
  config.vm.provision :shell, :inline => $script
end
