let Podenv = ../Podenv.dhall

let setup = ../Builders/nix.dhall

let -- | Add nix to the application environment
    nixify =
      \(app : Podenv.Application.Type) ->
            app
        //  { environ =
                  [ "NIX_PATH=/nix/var/nix/profiles/per-user/user/channels"
                  , "NIX_SSL_CERT_FILE=/etc/pki/tls/certs/ca-bundle.crt"
                  , "PATH=/profile/nix.unstable/bin:/profile/nix/bin:/bin"
                  ]
                # app.environ
            , volumes = setup.volumes # app.volumes
            }

in  nixify
