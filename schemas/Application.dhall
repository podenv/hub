{ Type =
    { -- | The application name, default to the parent key.
      name : Text
    , description : Optional Text
    , -- | The application runtime.
      runtime : ./Runtime.dhall
    , -- | An optional namespace name.
      namespace : Optional Text
    , -- | The application capabilities.
      capabilities : (./Capabilities.dhall).Type
    , -- | List of system capabilities(7).
      syscaps : List Text
    , -- | Process environment.
      environ : List Text
    , -- | Extra volumes.
      volumes : List Text
    , -- | Optional command and its argument.
      command : List Text
    }
, default =
  { -- The name defaults to the cli selector
    name = ""
  , description = None Text
  , namespace = None Text
  , capabilities = (./Capabilities.dhall).default
  , syscaps = [] : List Text
  , environ = [] : List Text
  , volumes = [] : List Text
  , command = [] : List Text
  }
}
