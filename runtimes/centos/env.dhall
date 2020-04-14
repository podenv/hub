let version = "8"

in  (../../schemas/Env)::{
    , name = "centos"
    , description = Some "Centos ${version} root shell"
    , image = Some "registry.centos.org/centos:${version}"
    , capabilities = (../../schemas/Caps)::{ terminal = Some True }
    , mounts = Some
      [ ../../functions/mkMount.dhall
          "/var/cache/dnf"
          "~/.cache/podenv/dnf-${version}"
      ]
    }
