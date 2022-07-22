{ Type =
    { network : ./Network.dhall
    , display : ./Display.dhall
    , volumes : List Text
    }
, default =
  { network = (./Network.dhall).Private
  , display = (./Display.dhall).HostDisplay
  , volumes = [] : List Text
  }
}
