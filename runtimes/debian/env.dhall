let version = "buster"

in  (../../schemas/Env)::{
    , name = "debian"
    , description = Some "debian ${version} root shell"
    , image = Some "docker.io/library/debian:${version}"
    , capabilities = (../../schemas/Caps)::{ terminal = Some True }
    , mounts = Some
      [ ../../functions/mkMount.dhall
          "/var/cache/apt"
          "~/.cache/podenv/apt-${version}"
      ]
    }
