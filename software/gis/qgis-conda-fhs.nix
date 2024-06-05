{ pkgs ? import <nixpkgs> {}}:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "my-qgis-conda-fhs-environment";

    targetPkgs = _: [
      pkgs.micromamba
    ];
  
    profile = ''
      set -e
      eval "$(micromamba shell hook --shell=posix)"
      export MAMBA_ROOT_PREFIX=~/micromamba
      if ! test -d $MAMBA_ROOT_PREFIX/envs/qgis-conda-env; then
          micromamba create --yes -n qgis-conda-env qgis
      fi
      micromamba activate qgis-conda-env
      # Always update packages in the environment
      micromamba update --yes
      set +e
    '';
  };
in fhs.env