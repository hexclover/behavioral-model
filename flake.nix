{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
  };
  outputs = { self, nixpkgs }: {
    devShells =
      let system = "x86_64-linux"; in {
        ${system}.default =
          let pkgs = import nixpkgs { inherit system; }; in
          pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              autoconf
              automake
              libtool
              pkg-config
            ];

            buildInputs = with pkgs; [
              boost
              gmp
              libpcap
              nanomsg
              thrift
              (python3.withPackages (p: with p; [ thrift ]))
            ];
          };
      };
  };
}
