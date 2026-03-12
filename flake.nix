{
  description = "dev env flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs = { self, nixpkgs }: let
    allSystems = [
    "aarch64-linux"
      "x86_64-linux"
    ];
  mkShell = system: let 
  pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    default = pkgs.mkShell {
      nixpkgs.config.allowUnfree = true;
      packages = with pkgs; [
        flutter
        android-studio-full
      ];
      # shellHook =''
      #   export NIXPKGS_ALLOW_UNFREE=1
      #   '';
    };
  };
  in {
    devShells = nixpkgs.lib.genAttrs allSystems mkShell;
  };
}
