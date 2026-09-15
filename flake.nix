{
  description = "My NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    {
      packages."x86_64-linux".dockerImage =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.dockerTools.buildImage {
          name = "yodogawa404/20260915-php-test";
          tag = "latest";
          created = "now";

          copyToRoot = pkgs.buildEnv {
            name = "image-root";
            paths = with pkgs; [
              busybox
              coreutils
              bash
              php
              phpPackages.composer
              nodejs
            ];
          };

          extraCommands = "
            mkdir -p usr/bin
            ln -s /bin/env usr/bin/env
          ";

          config = {
            Cmd = [ "/bin/sh" ];
            Env = [
              "PATH=/bin"
              "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            ];
          };
        };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
