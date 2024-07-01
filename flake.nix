{

  description = "A simple flake for my project";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self, 
    nixpkgs,
    flake-utils,
  }: let 
    supportedSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
      "x86_64-darwin"
    ]; 
  in flake-utils.lib.eachSystem supportedSystems (
    system: let 
      pkgs = nixpkgs;
      makeShell = p: 
        p.mkShell {
          buildInputs = with p; [ 
            bloop
            coursier
            jdk
            sbt
            scalafmt
          ];
        };
    in {
      devShells = {
        default = makeShell pkgs.default;
        java21 = makeShell pkgs.pkgs21;
        java17 = makeShell pkgs.pkgs17;
        java11 = makeShell pkgs.pkgs11;
        java8 = makeShell pkgs.pkgs8;
      };
    }
  );
}
