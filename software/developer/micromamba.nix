{ pkgs ? import <nixpkgs> {}}: {
  environment.systemPackages = with pkgs; [
    micromamba
  ];
}
