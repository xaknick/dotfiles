{ config, pkgs, ... }:

{
  environment.systemPackages = [ 
    pkgs.postgresql
    pkgs.dotnet-sdk_8
  ];

  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      postgres = {
        image = "postgres:alpine";
        hostname = "postgres";
        ports = [ "127.0.0.1:5432:5432" ];
        environment = {
          POSTGRES_PASSWORD = "mysecretpassword";
        };
      };
      redis = {
        image = "redis:alpine";
        hostname = "redis";
        ports = [ "127.0.0.1:6379:6379" ];
      };
    };
  };
}
