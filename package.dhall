{- Welcome to the hub package.

   * 'Defaults' is the podenv defaults environment list.
   * 'Environments' is a collection of environments template to build your own list.
   * 'Functions' are utility procedures to manipulate environment.
   * 'Runtimes' are functions to define environment runtime.
   * 'Prelude' is a copy of the dhall-lang library 'Prelude'.
-}
{ Defaults = ./defaults.dhall : List ./types/Env
, Environments = ./environments.dhall
, Functions = ./functions.dhall
, Runtimes = ./runtimes.dhall
, Prelude = ./Prelude.dhall
}
