-- | The default nix builder
let Prelude = ../Prelude.dhall

let Podenv = ../Podenv.dhall

let home = "/home/user"

in  Podenv.Application::{
    , description = Some "Setup a nix store in a podman volume"
    , capabilities = Podenv.Capabilities::{ network = True }
    , command =
        let version = "2.3.15"

        let hash =
              "aae346f0ee447efa042c38e320aee0368e3c6c7fa331d76f708bbe8539f694fa"

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
                  , "ln -s /nix/var/nix/profiles/per-user/user/profile /nix/var/nix/profiles/default"
                  , "/nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old"
                  , "/nix/var/nix/profiles/default/bin/nix-store --optimise"
                  , "/nix/var/nix/profiles/default/bin/nix-store --verify --check-contents"
                  ]
              , "); nix --version"
              ]

        in  [ "bash", "-c", Prelude.Text.concatSep " " args ]
    , runtime =
        let uid = "\${USER_UID}"

        let cmds =
              [ "dnf update -y"
              , "dnf install -y xz ncurses-compat-libs"
              , ./mkUser.dhall "user"
              , "mkdir -m 0755 -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf"
              , "dnf clean all"
              ]

        in  Podenv.Container
              Podenv.ContainerBuild::{
              , image_name = Some "local-nix"
              , image_volumes = [ "nix-store:/nix" ]
              , image_home = Some home
              , containerfile =
                  ''
                  # Adapted from https://github.com/NixOS/docker/blob/master/Dockerfile
                  FROM registry.access.redhat.com/ubi8:latest
                  ARG USER_UID
                  RUN ${Prelude.Text.concatSep " && " cmds}
                  RUN ln -sf /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/ && mkdir -m 0755 -p /etc/nix && echo -e 'sandbox = false\nbuild-users-group =' > /etc/nix/nix.conf
                  ENV USER=user
                  ENV HOME=${home}
                  ENV PATH=/nix/var/nix/profiles/default/bin:/bin:/sbin
                  ENV GIT_SSL_CAINFO=/etc/pki/tls/certs/ca-bundle.crt
                  ENV NIX_SSL_CERT_FILE=/etc/pki/tls/certs/ca-bundle.crt
                  ENV NIX_PATH=/nix/var/nix/profiles/per-user/user/channels
                  ''
              }
    }
