VERSION=6.1.0

ORIG_TAR=jboss_$(VERSION)-Final.orig.tar.gz
ZIP_FILE=jboss-as-distribution-6.1.0.Final.zip
DEST=jboss

all: jboss/jar-versions.xml
	#(cd jboss; debuild -us -uc)

clean:

	rm -rf tmp


	(cd jboss; debuild clean)
	find jboss -mindepth 1 -maxdepth 1 ! -name debian -exec rm -rf {} \;
	true

dist-clean: clean

	rm -f $(ORIG_TAR)
	rm -f $(ZIP_FILE)

jboss/jar-versions.xml: $(ORIG_TAR)
	tar -xzvf $(ORIG_TAR) -C $(DEST)
	true

$(ORIG_TAR): $(ZIP_FILE)
	unzip -d tmp $(ZIP_FILE)
	(cd tmp/jboss-6.1.0.Final; tar -czf ../../$(ORIG_TAR) *)
	rm -rf tmp

$(ZIP_FILE):
	wget http://download.jboss.org/jbossas/6.1/$(ZIP_FILE)
