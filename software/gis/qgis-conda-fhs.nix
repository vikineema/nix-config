{ pkgs ? import <nixpkgs> {}}:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "my-qgis-conda-environment";

    targetPkgs = _: [
      pkgs.micromamba
      pkgs.libGL
    ];

    profile = ''
      set -e

      # Modify your shell variables to include the micromamba command
      eval "$(micromamba shell hook --shell=posix)"
      export MAMBA_ROOT_PREFIX=~/micromamba
      
      # For some reason this requires micromamba to be installed system wide.
      # Set up conda-forge exclusively
      micromamba config append channels conda-forge
      micromamba config append channels nodefaults
      micromamba config set channel_priority strict

      if ! test -d $MAMBA_ROOT_PREFIX/envs/qgis-conda-env; then
          micromamba create --yes -n qgis-conda-env qgis libgdal-arrow-parquet
      fi
      micromamba activate qgis-conda-env
      micromamba update
    '';
  };
in fhs.env