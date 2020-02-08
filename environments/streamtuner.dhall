(../schemas/Env)::{
, name = "streamtuner"
, description = Some "An internet radio browser"
, url = Some "http://milki.include-once.org/streamtuner2"
, packages = Some [ "streamtuner" ]
, command = Some [ "streamtuner2" ]
, capabilities = (../schemas/Caps)::{
  , x11 = Some True
  , network = Some True
  , pulseaudio = Some True
  }
}
