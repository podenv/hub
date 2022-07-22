{ Type =
    { metadata : (./Metadata.dhall).Type
    , kind : Text
    , apiVersion : Text
    , resources : (./Resources.dhall).Type
    , application : (./Application.dhall).Type
    }
, default =
  { metadata = (./Metadata.dhall).default
  , kind = "Application"
  , apiVersion = "podenv/0.2"
  , resources = (./Resources.dhall).default
  , application = (./Application.dhall).default
  }
}
