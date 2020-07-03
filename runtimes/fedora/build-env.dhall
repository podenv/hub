\(version : Text) ->
  Some
    ( ../mkBuildEnv.dhall
        [ ../../functions/mkMount.dhall
            "/var/cache/dnf"
            "~/.cache/podenv/dnf-${version}"
        ]
    )
