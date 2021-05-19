let env =
      ../functions/addCap.dhall
        ( \(env : ../types/Env) ->
                env.capabilities
            //  { terminal = Some True
                , alsa = Some True
                , dri = Some True
                , x11 = Some True
                , pulseaudio = Some True
                }
        )
        (../schemas/Env)::{
        , name = "vcv"
        , description = Some "The EuroRack simulator"
        , command = Some [ "Rack" ]
        , packages = Some
          [ "Rack-v1"
          , "mesa-dri-drivers"
          , "rack-v1-Bogaudio"
          , "rack-v1-AudibleInstruments"
          , "rack-v1-Valley"
          , "rack-v1-Befaco"
          , "rack-v1-Bidoo"
          , "rack-v1-VCV-Recorder"
          , "rack-v1-DrumKit"
          ]
        }

in  (../runtimes/fedora/create.dhall).Base
      "33"
      [ (../schemas/Task)::{
        , name = Some "Enable copr"
        , shell = Some
            "dnf -y install dnf-plugins-core && dnf -y copr enable ycollet/linuxmao"
        }
      ]
      env
