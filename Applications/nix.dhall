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

let use =
      \(expr : Text) ->
        Podenv.Nix "let pkgs = (import <nixpkgs> {}); in ${expr}"

let default =
      Podenv.Application::{
      , capabilities = Podenv.Capabilities::{
        , terminal = True
        , interactive = True
        , network = True
        }
      , runtime = use "pkgs.nix"
      , environ = [ "PS1=nix\$ " ]
      }

let unstable = default // { runtime = use "pkgs.nixUnstable" }

let shell =
      \(expr : Text) ->
            unstable
        //  { description = Some
                "Start a nix-shell, use --cwd to mount the current working directory"
            , command = [ "nix-shell", "-p", expr ]
            }

in  { setup, nixify, use, default, unstable, shell }
