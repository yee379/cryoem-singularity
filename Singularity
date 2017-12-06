Bootstrap: yum
OSVersion: 7
MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/
Include: yum epel-release environment-modules vim tree

%labels

  AUTHOR ytl@slac.stanford.edu

%runscript

  module() { eval `/usr/bin/modulecmd bash $*`; }
  export -f module
  exec echo "Choose an app to run with --app [MotionCor2|]"


%apprun MotionCor2

  module() { eval `/usr/bin/modulecmd bash $*`; }
  export -f module
  module load $(module avail -l 2>&1 | grep motioncor2 | awk '{print $1}' | head -n1)
  MotionCor2 "$@"    

%appinstall MotionCor2

  # install image alignment software
  yum install -y compat-libtiff3
  export SPACK_ROOT=/opt/spack/
  . $SPACK_ROOT/share/spack/setup-env.sh
  spack install motioncor2@1.0.2


%apprun imod

  module() { eval `/usr/bin/modulecmd bash $*`; }
  export -f module
  module load $(module avail -l 2>&1 | grep imod | awk '{print $1}' | head -n1)

%appinstall imod

  export SPACK_ROOT=/opt/spack/
  . $SPACK_ROOT/share/spack/setup-env.sh
  spack -k install imod@4.9.4 ^fftw~mpi+openmp ^hdf5~mpi


%apprun eman2

  module() { eval `/usr/bin/modulecmd bash $*`; }
  export -f module
  module load $(module avail -l 2>&1 | grep eman2 | awk '{print $1}' | head -n1)

%appinstall eman2

  export SPACK_ROOT=/opt/spack/
  . $SPACK_ROOT/share/spack/setup-env.sh
  spack install python
  export CPLUS_INCLUDE_PATH=`spack location -i python`/include/python2.7/
  # for bison and tar
  export FORCE_UNSAFE_CONFIGURE=1
  spack -k install eman2@master ~cuda ^boost@1.58.0+python  ^fftw+openmp~mpi  ^cmake ~doc+ncurses+openssl+ownlibs~qt ^hdf5~mpi ^qt@4.8.6+dbus~examples~gtk~krellpatch+opengl+phonon~webkit ^mesa+llvm+swrender ^mesa-glu+mesa


%apprun ctffind4

  module() { eval `/usr/bin/modulecmd bash $*`; }
  export -f module
  module load $(module avail -l 2>&1 | grep eman2 | awk '{print $1}' | head -n1)

%appinstall ctffind4

  export SPACK_ROOT=/opt/spack/
  . $SPACK_ROOT/share/spack/setup-env.sh
  spack install intel-mkl@2017.4.239
  export INCLUDES=" -I`spack location -i intel-mkl@2017.4.239`/mkl/include"
  spack install --keep-stage ctffind4 ^fftw~mpi+openmp ^pango+X ^gtkplus+X ^intel-mkl@2017.4.239




%environment
  export SPACK_ROOT=/opt/spack/    
  export MODULEPATH=/usr/share/Modules/modulefiles:/etc/modulefiles
  
%post
    
  echo "Setting up..."
  yum group install -y "Development Tools"
  
  echo "Installing SPACK..."
  export SPACK_ROOT=/opt/spack/
  mkdir $SPACK_ROOT
  git clone https://github.com/spack/spack.git /opt/spack/

  # add cryoem packages
  git clone https://github.com/slaclab/slac-cryoem-spack.git /opt/spack/var/spack/repos/slac-cryoem-spack
  . $SPACK_ROOT/share/spack/setup-env.sh
  spack repo add $SPACK_ROOT/var/spack/repos/slac-cryoem-spack

  # enable module to autoload libs and deps
  tee $SPACK_ROOT/etc/spack/defaults/modules.yaml <<-'__EOF__'

  modules:
    enable:
      - tcl

    prefix_inspections:
      bin:
        - PATH
      man:
        - MANPATH
      share/man:
        - MANPATH
      share/aclocal:
        - ACLOCAL_PATH
      lib:
        - LIBRARY_PATH
        - LD_LIBRARY_PATH
      lib64:
        - LIBRARY_PATH
        - LD_LIBRARY_PATH
      include:
        - CPATH
      lib/pkgconfig:
        - PKG_CONFIG_PATH
      lib64/pkgconfig:
        - PKG_CONFIG_PATH
      '':
        - CMAKE_PREFIX_PATH
  
    tcl:
      verbose: False
      autoload:  'direct'

      all:
        autolaod: 'direct'

      ^python:
        autoload: 'direct'
      ^openmpi:
        autoload: 'direct'
      ^cuda:
        autoload: 'direct'
      
__EOF__
  
  echo "Setting up environment-modules"
  ln -sf /usr/share/Modules/init/sh /etc/profile.d/modules.sh
  ln -sf /usr/share/Modules/init/csh /etc/profile.d/modules.csh
  rm -rf /etc/modulefiles/
  ln -sf $SPACK_ROOT/share/spack/modules/linux-centos7-x86_64/ /etc/modulefiles
  
  # clean up
  rm -rf $SPACK_ROOT/var/spack/stage/*
