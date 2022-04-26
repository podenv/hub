-- | The default nix builder
let Prelude = ../Prelude.dhall

let Podenv = ../Podenv.dhall

let home = "/home/user"

in  Podenv.Application::{
    , description = Some "Setup the nix store"
    , capabilities = Podenv.Capabilities::{ network = True }
    , command =
        let version = "2.8.0"

        let hash =
              "0b32afd8c9147532bf8ce8908395b1b4d6dde9bedb0fcf5ace8b9fe0bd4c075c"

        let args =
              [ "test -d /nix/var || ("
              , Prelude.Text.concatSep
                  " && "
                  [ "cd /tmp"
                  , "curl -OL https://nixos.org/releases/nix/nix-${version}/nix-${version}-x86_64-linux.tar.xz"
                  , "echo '${hash}  nix-${version}-x86_64-linux.tar.xz' | sha256sum -c"
                  , "tar xf nix-${version}-x86_64-linux.tar.xz"
                  , "/tmp/nix-${version}-x86_64-linux/install"
                  , "rm -r /tmp/nix-*-x86_64-linux*"
                  , "cp -P /nix/var/nix/profiles/per-user/\$(id -nu)/profile-1-link /nix/var/nix/profiles/nix-install"
                  , "/nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old"
                  , "/nix/var/nix/profiles/default/bin/nix-store --optimise"
                  , "/nix/var/nix/profiles/default/bin/nix-store --verify --check-contents"
                  ]
              , "); /nix/var/nix/profiles/nix-install/bin/nix --version"
              ]

        in  [ "bash", "-c", Prelude.Text.concatSep " " args ]
    , volumes = [ "nix-store:/nix", "nix-setup-home:~/" ]
    , runtime = Podenv.Rootfs "/"
    }
