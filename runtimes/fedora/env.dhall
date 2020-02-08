let version = "31"

in  (../../schemas/Env)::{
    , name = "fedora"
    , description = Some "Fedora ${version} root shell"
    , image = Some "registry.fedoraproject.org/fedora:${version}"
    , capabilities = (../../schemas/Caps)::{ terminal = Some True }
    , mounts = Some
        [ ../../functions/mkMount.dhall
            "/var/cache/dnf"
            "~/.cache/podenv/dnf-${version}"
        ]
    }
