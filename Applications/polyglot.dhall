(../Podenv.dhall).Application::{
, description = Some "Tool to count lines of source code."
, runtime = (../Podenv.dhall).Nix ./polyglot.nix as Text
, command = [ "poly" ]
}
