{- The podenv package of types and schemas

   When podenv loads the configuration, it provides the location of the package
   through the PODENV environment variable.
   This file also includes fallbacks so that the hub expressions can be easily
   evaluated from the command line.
-}
  env:PODENV
? ~/src/github.com/podenv/podenv/package.dhall
? https://raw.githubusercontent.com/podenv/podenv/9e404b161812b139e89d6724e44a3ac753ec24c2/package.dhall sha256:14f292a33ac754646a01bedc655e6cde5b16704937f968141af4e28cd0f88474
