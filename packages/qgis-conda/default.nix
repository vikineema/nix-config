{pkgs ? import <nixpkgs> {}}:
pkgs.buildFHSUserEnv {
  name = "fhsQgis";

  targetPkgs = pkgs: [
    pkgs.micromamba
    pkgs.libGL
  ];

  profile = ''
    set -e

    # Set up micromamba and initialize the shell
    export MAMBA_EXE=$(which micromamba)
    export MAMBA_ROOT_PREFIX=~/micromamba
    eval "$($MAMBA_EXE shell hook --shell=posix --prefix=$MAMBA_ROOT_PREFIX)"

    # Configure an exclusive conda set up
    micromamba config append channels conda-forge
    micromamba config set channel_priority strict

    # Create the required environment:
    if ! test -d $MAMBA_ROOT_PREFIX/envs/qgis-conda-env; then
        micromamba create --yes -n qgis-conda-env qgis libgdal-arrow-parquet
    fi

    # Activate the environment.
    micromamba activate qgis-conda-env

    # Always update to the latest
    # micromamba update

    set +e
  '';
  runScript = "qgis";
}
