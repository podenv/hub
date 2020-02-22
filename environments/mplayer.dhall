../functions/addCap.dhall
  (     \(env : ../types/Env)
    ->  env.capabilities // { pulseaudio = Some True, dri = Some True }
  )
  (     ./_graphicEditor.dhall "mplayer" "Media player software"
    //  { packages = Some
          [ "mplayer"
          , "libvdpau-va-gl"
          , "mesa-dri-drivers"
          , "libva-intel-driver"
          , "libva-intel-hybrid-driver"
          ]
        }
  )
