{- Graphic editor template
-}
\(name : Text) ->
\(description : Text) ->
  ../functions/capFs.dhall
    ( ../functions/capGraphics.dhall
        (../functions/mkSimpleEnv.dhall name description)
    )
