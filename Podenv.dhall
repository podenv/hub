{- The podenv package of types and schemas

   When podenv loads the configuration, it provides the location of the package
   through the PODENV environment variable.
   This file also includes fallbacks so that the hub expressions can be easily
   evaluated from the command line.
-}
  env:PODENV
? ~/src/github.com/podenv/podenv/package.dhall
? https://raw.githubusercontent.com/podenv/podenv/7a28378f49982e32e76f0ed249aa9b83079e0689/package.dhall sha256:096fca44bb3889cfdcd33d68c804ed3cd1dcac0d95b5b20a1cf3b728cc9487cd
