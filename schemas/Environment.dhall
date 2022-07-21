{ Type =
    { name : Optional Text
    , volumes : List Text
    , network : Optional ./Network.dhall
    , display : ./Display.dhall
    }
, default =
  { name = None Text
  , display = (./Display.dhall).Host
  , network = None ./Network.dhall
  , volumes = [] : List Text
  }
}
