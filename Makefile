VERSION=6.1.0

ORIG_TAR=jboss_$(VERSION)-Final.orig.tar.gz
ZIP_FILE=jboss-as-distribution-6.1.0.Final.zip
DEST=jboss

all: jboss/jar-versions.xml
	(cd jboss; patch -p1 <debian/patches/add_makefile.diff)
	(cd jboss; patch -p1 <debian/patches/add_deployer.diff)
	(cd jboss; debuild -us -uc)

clean:

	rm -rf $(DEST)/bin
	rm -rf $(DEST)/client
	rm -rf $(DEST)/common
	rm -rf $(DEST)/docs
	rm -rf $(DEST)/lib
	rm -rf $(DEST)/server
	rm -rf $(DEST)/copyright.txt
	rm -rf $(DEST)/jar-versions.xml
	rm -rf $(DEST)/LICENSE.txt
	rm -rf $(DEST)/usr
	rm -f  $(DEST)/Makefile

	rm -f jboss_$(VERSION)*.build
	rm -f jboss_$(VERSION)*.changes
	rm -f jboss_$(VERSION)*.deb
	rm -f jboss_$(VERSION)*.debian.tar.gz
	rm -f jboss_$(VERSION)*.dsc

	rm -rf tmp


	(cd jboss; debuild clean)
	true

dist-clean: clean

	rm -f $(ORIG_TAR)
	rm -f $(ZIP_FILE)

jboss/jar-versions.xml: $(ORIG_TAR)
	tar -xzvf $(ORIG_TAR) -C $(DEST)


$(ORIG_TAR): $(ZIP_FILE)
	unzip -d tmp $(ZIP_FILE)
	(cd tmp/jboss-6.1.0.Final; tar -czvf ../../$(ORIG_TAR) *)
	rm -rf tmp

$(ZIP_FILE):
	wget http://download.jboss.org/jbossas/6.1/$(ZIP_FILE)
