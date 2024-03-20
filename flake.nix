{
  description = "UVMHS Development Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    vim-flake.url = "github:EthanJamesLew/elew-vim"; 
  };

  outputs = { self, nixpkgs, flake-utils, vim-flake }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        ghc = pkgs.haskell.packages.ghc964.ghc;
        hls = pkgs.haskellPackages.haskell-language-server;
        nvim = vim-flake.packages.${system}.default;
        
        dockerImage = pkgs.dockerTools.buildImage {
          name = "uvmhs";
          tag = "latest";
          contents = [ ghc hls nvim ];
        };
      in {
        packages = {
          inherit dockerImage;
        };

        devShell = pkgs.mkShell {
          buildInputs = [ ghc hls nvim ];
        };
      });
}

