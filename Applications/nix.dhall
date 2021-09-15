let Podenv = ../Podenv.dhall

let setup = ../Builders/nix.dhall

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

in  { setup, use, default, unstable, shell }
