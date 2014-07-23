
# Inline provisioning script
$script = <<SCRIPT
apt-get update
apt-get -y --force-yes install devscripts build-essential fakeroot debhelper gnupg dh-make
cd /vagrant/jboss
yes | mk-build-deps --install debian/control
SCRIPT

Vagrant::Config.run do |config|
  config.vm.box = "wheezy"
  config.vm.box_url = "http://hudson2-test.colo.elex.be/wheezy64.box"
  config.vm.customize ["modifyvm", :id, "--memory", 1024]
  config.vm.provision :shell, :inline => $script
end
