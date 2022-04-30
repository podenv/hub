let Podenv = ../Podenv.dhall

let setup = ../Builders/nix.dhall

let -- | A pinned reference for the nixpkgs
    nixpkgs =
      "github:NixOS/nixpkgs/7954a245e70238e08078baef7ff6459a67e229c3"

let -- | Setup a Nix runtime with custom installables and nixpkgs packages.
    uses =
      \(qualifiedInstallables : List Text) ->
      \(pkgs : List Text) ->
        Podenv.Nix
          Podenv.Flakes::{
          , nixpkgs = Some nixpkgs
          , installables =
                qualifiedInstallables
              # (../Prelude.dhall).List.map
                  Text
                  Text
                  (\(pkgs : Text) -> "${nixpkgs}#${pkgs}")
                  pkgs
          }

let usesExample =
        assert
      :     uses [ "flakes/url" ] [ "bash" ]
        ===  Podenv.Nix
               Podenv.Flakes::{
               , nixpkgs = Some nixpkgs
               , installables = [ "flakes/url", "${nixpkgs}#bash" ]
               }

let -- | Setup a Nix runtime with nixpkgs packages
    use =
      uses ([] : List Text)

let -- | Setup a Nix runtime
    useInstallables =
      \(installables : List Text) -> Podenv.Nix Podenv.Flakes::{ installables }

let useExample =
        assert
      :     use [ "bash" ]
        ===  Podenv.Nix
               Podenv.Flakes::{
               , nixpkgs = Some nixpkgs
               , installables = [ "${nixpkgs}#bash" ]
               }

let default =
      Podenv.Application::{
      , description = Some "A shell with nix"
      , capabilities = Podenv.Capabilities::{
        , terminal = True
        , interactive = True
        , network = True
        }
      , runtime = use [ "nix" ]
      , command = [ "sh" ]
      }

let shell =
      \(pkg : Text) ->
        Podenv.Application::{
        , description = Some "A shell with a nix package"
        , capabilities = Podenv.Capabilities::{
          , terminal = True
          , interactive = True
          }
        , runtime = use [ pkg ]
        , command = [ "sh" ]
        }

in  { setup, use, uses, useInstallables, default, shell }
