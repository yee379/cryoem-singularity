# cryoem-singularity
Common cryoem applications and tools packaged into a singularity container.

One of the pains of setting up cryoem software is that it often difficult to setup to work in your HPC (or even desktop) environment. This repo contains a singularity recipe to automatically build a common set of cryoem tools and applications to ease the process of getting started.

# Why [Singularity](http://singularity.lbl.gov/)?

Singularity is a container technology, that like VMs, allow portability of applications and codes across different computer (linux) environments. The most popular container technology is [Docker](https://www.docker.com/).

However, due to the way Docker works, it is quite insecure and assumes that you have administrative priviledges on the system that you are running on. (Un)fortunately, most users of HPC resources do not have sudo or root; in addition, most HPC centers do not or cannot run the latest kernels to enable Docker (reliably). This is where Singularity steps in. You can build the image from another machine (where you do have administrative priviledges) and simply copy the entire (resultant) container image to your HPC shared file system (with Docker you have to fluff around with repositories etc) and start using your containerised environment immediately (as long as the singularity runtime is [enabled](http://singularity.lbl.gov/install-linux) on your HPC system)

# What cryoem applications are installed?

* [IMOD](http://bio3d.colorado.edu/imod/)
* [EMAN2](http://blake.bcm.edu/emanwiki/EMAN2/)
* [MotionCor2](http://msg.ucsf.edu/em/software/motioncor2.html)

The following are to be implemented (suggestions welcome! pull requests even more welcome!)
* [Relion](http://www2.mrc-lmb.cam.ac.uk/relion/index.php/Main_Page)
* [CTFFind4](http://grigoriefflab.janelia.org/ctffind4)

# How do I use this?!

TBA


# Technical details

Rather than copying binaries (unless necessary) into the container, I strive to compile all applications from source. As anyone who's compile software before, this can be rather hit or miss. In order to ease this process, this container uses [spack](https://spack.io/) in order to process and install dependencies. A series of [custom spack packages for cryoem](https://github.com/slaclab/slac-cryoem-spack) have been written and incorporated into this container. As you will note from the singularity definition, the building of this container image simply runs spack commands in order to download, build and install the applications.


