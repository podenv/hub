let Nix =
      \(version : Text) ->
      \(hash : Text) ->
      \(env : ../../types/Env) ->
            env
        //  { build-env = Some
              { mounts =
                    ./mounts.dhall
                  # [ ../../functions/mkMount.dhall
                        "/var/cache/dnf"
                        "~/.cache/podenv/dnf-latest"
                    ]
              }
            , mounts = Some
                (   merge
                      { None = [] : List ../../types/Mount
                      , Some = \(mounts : List ../../types/Mount) -> mounts
                      }
                      env.mounts
                  # ./mounts.dhall
                )
            , user = Some (../defaultUser.dhall env.user)
            , container-file =
                ../fromText.dhall
                  ''
                  # Adapted from https://github.com/NixOS/docker/blob/master/Dockerfile
                  FROM registry.fedoraproject.org/fedora:latest

                  RUN dnf update -y && dnf install -y xz ncurses-compat-libs                                       \
                    && useradd -u 1000 -d /home/user -m user && mkdir -p /run/user/1000                            \
                    && chown 1000:1000 /run/user/1000 && mkdir -p /run/user/0 && chown 0:0 /run/user/0

                  RUN test -d /nix/var || ( cd /                                                                   \
                    && curl -OL https://nixos.org/releases/nix/nix-${version}/nix-${version}-x86_64-linux.tar.xz   \
                    && echo "${hash}  nix-${version}-x86_64-linux.tar.xz" | sha256sum -c                           \
                    && tar xf nix-${version}-x86_64-linux.tar.xz                                                   \
                    && mkdir -m 0755 -p /etc/nix                                                                   \
                    && echo 'sandbox = false' > /etc/nix/nix.conf                                                  \
                    && mkdir -m 0755 -p /nix && chown -R user:user /nix /etc/nix                                   \
                    && su user -l -c "/nix-${version}-x86_64-linux/install --no-daemon"                            \
                    && ln -s /nix/var/nix/profiles/per-user/user/profile/ /nix/var/nix/profiles/default            \
                    && ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/                    \
                    && rm -r /nix-*-x86_64-linux*                                                                  \
                    && su user -l -c "/nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old"          \
                    && su user -l -c "/nix/var/nix/profiles/default/bin/nix-store --optimise"                      \
                    && su user -l -c "/nix/var/nix/profiles/default/bin/nix-store --verify --check-contents" )

                  RUN ln -sf /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/                    \
                    && mkdir -m 0755 -p /etc/nix                                                                   \
                    && echo 'sandbox = false' > /etc/nix/nix.conf                                                  \
                    && mkdir -m 0755 -p /nix && chown -R user:user /etc/nix

                  ENV \
                      ENV=/etc/profile \
                      USER=user \
                      PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin \
                      GIT_SSL_CAINFO=/etc/pki/tls/certs/ca-bundle.crt \
                      NIX_SSL_CERT_FILE=/etc/pki/tls/certs/ca-bundle.crt \
                      NIX_PATH=/nix/var/nix/profiles/per-user/user/channels
                  ''
            }

in  { Nix
    , Latest =
        Nix
          "2.3.11"
          "899d2aa3fe6e74d5ad38bd7d0c51dee0d85ecebf41447298b50ce30640018d2e"
    , Default =
        Nix
          "2.3"
          "e43f6947d1f302b6193302889e7800f3e3dd4a650b6f929c668c894884a02701"
    }
