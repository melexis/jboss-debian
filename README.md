# Create jboss packages

This project contains essentially a Makefile and a debian folder to
build jboss versions.

Although some effort has been made to make the scripts reusable, due
to the nature of the jboss server they should more be treated as
executable documentation of what needs to be done and will need to be
tweaked for new versions

# TL;DR

host build

    $ make clean; make
    $ cd jboss
    $ debuild -uc -us

or cleanroom build

    $ make clean; make
    $ cd jboss
    $ DIST=wheezy ARCH=amd64 pdebuild -uc -us




# The Main Makefile

Since downloading the zip file and creating and expanding the
*original* tar are fairly expensive these are cached by the
makefile. There are 2 clean targets for this : *clean* and
*dist-clean* which also removes the zip and tar.gz files.

When the zip or orig.tar.gz is missing then the Makefile will download
the zip and convert it to a tar file for debuild.

The download location is hardcoded in the $(ZIP_FILE) target.

In order to create a pristine jboss source folder to build the package
do:

    $ make clean; make

Now you have a new folder, without the patches applied.

# The jboss/Makefile

Note that this file only exist after applying all the patches (see
Using Quilt).  This just copies the stuff in place.

# the debian folder

This is a plain vanilla debian folder.

All the modifications are documented in the debian/patches folder.

Any changes made to the jboss folders or the Makefile must be
committed using

    $ dpkg-source --commit

This creates an additional patch file in the debian/patches folder and
will be applied by *debuild* automatically. Do not forget to add this
file to the git repo.

# Using Quilt

This package uses quilt for managing the patches. Normally you do not
*NEED* this if you use the tips above, but in practice I had to use it
all the time.

Start with creating a *~/.quiltrc* file with the contents

    QUILT_PATCHES=debian/patches
    QUILT_NO_DIFF_INDEX=1
    QUILT_NO_DIFF_TIMESTAMPS=1
    QUILT_REFRESH_ARGS="-p ab"

This will configure *quilt* to find the patches and the series file.

To apply all the patches use

    $ quilt push -a

To return to the pristine state, pop all patches of the code :

    $ quilt pop -a

To 'fix' a patch, apply it (and all previous ones), make the changes
and refresh the patch:

    $ quilt push some_patch_name
    $ _edit...hack...edit..._
    $ quilt refresh

That's it.

When editing a file which is not already in the patch, add it to the patch with

    $ quilt add some/filename.ext
    $ quilt refresh

To create a brand new patch, apply all patches, create the new patch,
add the files and refresh the patch.

    $ quilt push -a
    $ quilt new add_hot_new_feature.diff
    $ quilt add hot/new/feature/file.txt
    $ vi hot/new/feature/file.txt
    ... edit ... edit ...
    $ quilt refresh

For more info see [Using Quilt][using_quilt] on the Debian wiki.

[using_quilt]: https://wiki.debian.org/UsingQuilt "Using Quilt"


# Maintenance tips

- run *debchange -i* before committing

Actually just run *make commit*
