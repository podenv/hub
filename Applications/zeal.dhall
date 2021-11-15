    (./fedora.dhall).useGraphicSimple
      "zeal"
      "Offline documentation browser inspired by Dash"
//  { volumes = [ "cache-zeal:~" ]
    , capabilities = (../Podenv.dhall).Capabilities::{ x11 = True }
    }
