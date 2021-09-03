-- | Network utility
let Podenv = ../Podenv.dhall

let http-server =
      \(port : Text) ->
        Podenv.Application::{
        , runtime = Podenv.Image ((../Builders/fedora.dhall).image-ref "latest")
        , command = [ "python3", "-u", "-m", "http.server", port ]
        , capabilities = Podenv.Capabilities::{
          , host_network = True
          , cwd = True
          }
        }

in  { http-server }
