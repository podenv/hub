{ Devel =
        (../runtimes/fedora/create.dhall).Devel ./shell.dhall
    //  { name = "fedora-devel"
        , user = None (../Podenv.dhall).Types.User
        , mounts = Some
          [ ../functions/mkMount.dhall
              "/var/cache/dnf"
              "~/.cache/podenv/dnf-rawhide"
          ]
        }
}
