# Create jboss packages

This project contains essentially a Makefile and a debian folder to build jboss versions.

Although some effort has been made to make the scripts reusable, due
to the nature of the jboss server they should more be treated as executable documentation of what needs to be done and will need to be tweaked for new versions



# The Main Makefile

Since downloading the zip file and creating and expanding the *original* tar are fairly expensive these are cached by the makefile. There are 2 clean targets for this : *clean* and *dist-clean* which also removes the zip and tar.gz files.

When the zip or orig.tar.gz is missing then the Makefile will download the zip and convert it to a tar file for debuild.

The download location is hardcoded in the $(ZIP_FILE) target.

# The jboss/Makefile

This just copies the stuff in place.

It also cleans the folders containing files created at runtime to allow the folder to be used for testing without committing this stuff to the package.

Also the default ROOT.war is removed as it conflicts with some products.

# the debian folder

This is a plain vanilla debian folder.

Any changes made to the jboss folders or the Makefile must be committed using

    $ dpkg-source --commit

This creates an additional patch file in the debian/patches folder and will be applied by *debuild* automatically. Do not forget to add this file to the git repo.

# Maintenance tips

- run *debchange -i* before committing

Actually just run *make commit*
