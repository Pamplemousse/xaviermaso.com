{
  description = "xaviermaso.com's flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.11";
  };

  outputs = { self, flake-utils, nixpkgs }: flake-utils.lib.eachDefaultSystem (system:
    let
      nixpkgs-pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShell = nixpkgs-pkgs.mkShell {
        buildInputs = with nixpkgs-pkgs; [
          nodejs_20
          podman
        ];
      };
    }
  );
}
