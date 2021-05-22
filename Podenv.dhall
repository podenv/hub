{- The podenv package of types and schemas

   When podenv loads the configuration, it provides the location of the package
   through the PODENV_PRELUDE environment variable.
   This file also includes fallbacks so that the hub expressions can be easily
   evaluated from the command line.
-}
  env:PODENV_PRELUDE
? ~/src/github.com/podenv/podenv/podenv/dhall/package.dhall
? https://raw.githubusercontent.com/podenv/podenv/master/podenv/dhall/package.dhall
