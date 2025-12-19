{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem = {pkgs, ...}: {
        devShells = rec {
          database = let
            start-db = pkgs.writeShellScriptBin "start-db" (builtins.readFile ./database/bin/start-db.sh);
          in
            pkgs.mkShell rec {
              packages = [
                pkgs.docker
                pkgs.postgresql
                pkgs.postgrest
                pkgs.sqitchPg
                start-db
              ];
              DB_CONTAINER = "blits-dev-db";
              DB_NAME = "blits";
              DB_PASSWORD = "password";
              DB_PORT = "5432";
              DB_USER = "development";
              PGRST_DB_URI = "postgres://${DB_USER}:${DB_PASSWORD}@localhost:${DB_PORT}/${DB_NAME}";
            };
          default = hugo;
          hugo = pkgs.mkShell {
            packages = [
              pkgs.hugo
            ];
          };
        };
      };
    };
}
