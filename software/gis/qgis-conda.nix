{ config, pkgs, ... }:

let
  myQgisEnv = import ./qgis-conda-fhs.nix { inherit pkgs; };
in {
  environment.systemPackages = with pkgs; [
    myQgisEnv
  ];
}