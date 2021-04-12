with import <nixpkgs> {};
let
  namd3 = stdenv.mkDerivation {
    name = "namd3";
    
    src = fetchurl {
      url = http://www.ks.uiuc.edu/Research/namd/alpha/3.0alpha/download/NAMD_3.0alpha8_Linux-x86_64-multicore-CUDA-SingleNode.tar.gz;
      sha256 = "2fb089b48f38b41ad3613f2270fdda5cc804df14923041b113122e3be37e7c95";
    };
    phases = "installPhase";
    
    installPhase = ''
      mkdir -p $out/
      tar --strip-components=1 -C $out/ -xzf $src
    '';
  };
in
stdenv.mkDerivation {
  name = "openmpiEnv";
  buildInputs = [
    nix
    bash
    vim
    
    # NAMD deps?
    tcl
   
    #Finally, namd3
    namd3
  ];
  src = null;
  shellHook = ''
    export LANG=en_US.UTF-8
#    ln -sfn ${hpl.out}/bin/xhpl /usr/bin
    ln -sfn ${namd3.out}/namd3 /usr/bin/namd3
    ln -sfn ${namd3.out}/charmrun  /usr/bin/charmrun
    ln -sfn ${namd3.out}/flipbinpdb  /usr/bin/flipbinpdb
    ln -sfn ${namd3.out}/flipdcd /usr/bin/flipdcd
    ln -sfn ${namd3.out}/psfgen  /usr/bin/psfgen
    ln -sfn ${namd3.out}/sortreplicas /usr/bin/sortreplicas
    ln -sfn ${namd3.out}/lib /usr/lib
  '';
}
