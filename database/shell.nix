{pkgs, ...}: let
  python = pkgs.python3.withPackages (ps: [
    ps.pytest
    ps.requests
  ]);
  start-db = pkgs.writeShellScriptBin "start-db" (builtins.readFile ./bin/start-db.sh);
in
  pkgs.mkShell rec {
    packages = [
      pkgs.docker
      pkgs.postgresql
      pkgs.postgrest
      pkgs.sqitchPg
      python
      start-db
    ];
    DB_CONTAINER = "blits-dev-db";
    DB_NAME = "blits";
    DB_PASSWORD = "password";
    DB_PORT = "5432";
    DB_USER = "development";
    PGRST_DB_URI = "postgres://${DB_USER}:${DB_PASSWORD}@localhost:${DB_PORT}/${DB_NAME}";
  }
